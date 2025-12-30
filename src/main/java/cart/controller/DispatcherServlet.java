package cart.controller;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cart.command.CommandHandler;
import cart.command.NullHandler;

public class DispatcherServlet extends HttpServlet {

  private static final long serialVersionUID = 1L;

  private final Map<String, CommandHandler> handlerMap = new HashMap<>();
  private CommandHandler nullHandler = new NullHandler();

  @Override
  public void init(ServletConfig config) throws ServletException {
    super.init(config);

    String configFile = config.getInitParameter("configFile"); // /commandHandler.properties
    if (configFile == null || configFile.trim().isEmpty()) {
      throw new ServletException("configFile init-param is missing.");
    }

    Properties prop = new Properties();
    try (InputStream is = getServletContext().getResourceAsStream(configFile)) {
      if (is == null) {
        throw new ServletException("Cannot find " + configFile + " in webapp root.");
      }
      prop.load(is);

      for (Object k : prop.keySet()) {
        String uri = ((String) k).trim();                 // /cart/list.htm
        String className = prop.getProperty(uri).trim();  // cart.command.CartListHandler

        Class<?> clazz = Class.forName(className);
        CommandHandler handler = (CommandHandler) clazz.getDeclaredConstructor().newInstance();
        handlerMap.put(uri, handler);
      }

    } catch (Exception e) {
      throw new ServletException(e);
    }
  }

  @Override
  protected void service(HttpServletRequest request, HttpServletResponse response) {
    try {
      System.out.println(">>> DispatcherServlet HIT <<<"); // 여기!

      String uri = request.getRequestURI();
      String ctx = request.getContextPath();
      String path = uri.substring(ctx.length());

      System.out.println("path = " + path); // 이것도 같이 추천

      CommandHandler handler = handlerMap.getOrDefault(path, nullHandler);
      String view = handler.process(request, response);

      if (view == null) return;
      request.getRequestDispatcher(view).forward(request, response);

    } catch (Exception e) {
      try {
        throw new ServletException(e);
      } catch (ServletException se) {
        se.printStackTrace();
      }
    }
  }
}