# SIST_FILA
Java Servlet/JSP 기반 웹 애플리케이션  
Oracle + Tomcat JNDI(DataSource) 연동 프로젝트


프로젝트 파일 구조

```text
SIST_FILA/
├─ README.md
├─ build/
├─ src/
│  └─ main/
│     ├─ java/
│     │  └─ com/
│     │     ├─ util/
│     │     │  ├─ ConnectionProvider.java
│     │     │  ├─ Cookies.java
│     │     │  └─ JdbcUtil.java
│     │     │
│     │     └─ products/
│     │        ├─ productsDAO.java
│     │        ├─ productsDTO.java
│     │        └─ productsServlet.java
│     │
│     └─ webapp/
│        ├─ css/
│        ├─ js/
│        │
│        ├─ META-INF/
│        │  ├─ context.xml
│        │  └─ MANIFEST.MF
│        │
│        ├─ view/
│        │  ├─ admin/
│        │  ├─ event/
│        │  ├─ product/
│        │  └─ user/
│        │
│        └─ WEB-INF/
│           ├─ web.xml
│           └─ lib/
│              ├─ commons-beanutils-1.8.3.jar
│              ├─ commons-collections-3.2.jar
│              ├─ commons-lang-2.6.jar
│              ├─ commons-logging-1.1.1.jar
│              ├─ cos.jar
│              ├─ ezmorph-1.0.6.jar
│              ├─ json-lib-2.4-jdk15.jar
│              ├─ jstl-1.2.jar
│              ├─ lombok.jar
│              ├─ ojdbc6.jar
│              └─ tomcat-dbcp.jar
│
└─ Servers/


