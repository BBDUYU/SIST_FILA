package controller;

import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandHandler;
import command.NullHandler;
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024 * 5, // 5MB
	    maxFileSize = 1024 * 1024 * 50,      // 50MB
	    maxRequestSize = 1024 * 1024 * 100    // 100MB
	)
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public DispatcherServlet() {
        super();
    }

	@Override
	public void destroy() { 
		super.destroy();
		System.out.println("> DispatcherServlet.destroy()...");
	}

	// Map 객체 선언 
	//  key    요청URL
	//  value  fullName으로 실제 인스턴스를 생성해서 value 로 사용.
	public Map<String, CommandHandler> commandHandlerMap = new HashMap<String, CommandHandler>();
	
	@Override
	public void init() throws ServletException { 
		super.init();
		System.out.println("> DispatcherServlet.init()...");
		//  "/WEB-INF/commandHandler.properties"
		String mappingPath = this.getInitParameter("mappingPath");
		String realPath = this.getServletContext().getRealPath(mappingPath);
		// 실제 배포한 경로 - realPath
		
		Properties prop = new Properties();
		try (FileReader reader = new FileReader(realPath) ) {
			prop.load(reader);
		} catch (Exception e) { 
			throw new ServletException();
		}
		
		// key, value
        Set<Entry<Object, Object>> set = prop.entrySet();
        Iterator<Entry<Object, Object>> ir = set.iterator();
        while(ir.hasNext()) {
          Entry<Object, Object> entry = ir.next();
          String url = (String)entry.getKey();        // /board/list.do
          String fullName = (String)entry.getValue(); // days07.mvc.command.ListHandler
          
          Class<?> commandHandlerClass = null;

          try {
        	  commandHandlerClass = Class.forName(fullName);        	  
              CommandHandler handler =
                      (CommandHandler) commandHandlerClass
                              .getDeclaredConstructor()
                              .newInstance();

              this.commandHandlerMap.put(url, handler);

          } catch (InstantiationException |
                   IllegalAccessException |
                   InvocationTargetException |
                   NoSuchMethodException | ClassNotFoundException e) {
              e.printStackTrace();
          }
          
        } // while
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1) 요청 URL 분석 -> key		
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
		String requestURI =  request.getRequestURI();
		// > requestURI :                        /jspPro/board/list.do
		//System.out.println("> requestURI : " + requestURI);
		int beginIndex = request.getContextPath().length();
		requestURI =  requestURI.substring(beginIndex);
		System.out.println("> 요청된 requestURI : " + requestURI);
		// 2) 처리하는 모델객체 ( handler )
		CommandHandler handler = this.commandHandlerMap.get(requestURI);
		if( handler == null ) {
			handler = new NullHandler();
		}
		String viewPage = null;
		
		try {
			//          3) request 저장.
			viewPage = handler.process(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 4) 뷰페이지로 포워딩
		if (viewPage != null ) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
