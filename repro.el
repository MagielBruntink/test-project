;; setup java-debug server

;; $ git submodule init
;; $ git submodule update
;; $ cd java-debug
;; $ mvnw clean install


;; setup eglot-java

(package-install 'eglot-java)
(require 'eglot-java)

(setq jdtls-java-debug-plugin-jar
      (file-name-concat (expand-file-name ".")
                        "java-debug"
                        "com.microsoft.java.debug.plugin"
                        "target"
                        "com.microsoft.java.debug.plugin-0.51.1.jar"))

(defun my/eglot-java-init-opts (server eglot-java-eclipse-jdt)
    `(:bundles [,jdtls-java-debug-plugin-jar]))

(setopt eglot-java-user-init-opts-fn #'my/eglot-java-init-opts)


;; setup dape

(package-install 'dape)
(require 'dape)

(setq dape-configs
      `((jdtls
         modes (java-mode java-ts-mode)
         hostname "localhost"
         port (lambda () (eglot-execute-command (eglot-current-server)
                                                "vscode.java.startDebugSession" nil))
         :request "attach"
         :hostname "localhost"
         :port 8000
         :type "java"
         :projectName (lambda () (project-name (project-current))))))


;; setup repro

(with-current-buffer
    (find-file (file-name-concat (expand-file-name ".")
                                 "src" "test" "java" "Tests.java"))
  (eglot-java-mode +1)
  (goto-line 9)
  (dape--breakpoint-place)
  (eglot-java-run-test 1) ;; run test in debug mode
  )

;; M-x dape





