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
│     │     ├─ util/      # DB 연결 및 공통 유틸 클래스
│     │     │  ├─ ConnectionProvider.java    # JNDI 기반 DB 연결 관리
│     │     │  ├─ Cookies.java
│     │     │  └─ JdbcUtil.java
│     │     │
│     │     └─ # Model, Controller
│     │
│     └─ webapp/
│        ├─ css/
│        ├─ js/
│        ├─ resources/
│        │  └─ main_slider
│        │     └─ img
│        │  └─ product # 상품사진 저장공간
│        │     └─ product_pk.folder # 상품pk 폴더명
│        │        └─ img # 해당상품사진
│        ├─ META-INF/
│        │  ├─ context.xml # JNDI DataSource 설정
│        │  └─ MANIFEST.MF
│        │
│        ├─ Subset/
│        │  └─ SpoqHanSansEno # 글씨체
│        ├─ view/          # JSP View 기능별 분리
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
└─ Servers/                 # Eclipse Tomcat 서버 설정


