
;; setup eglot-java

(package-install 'eglot-java)
(require 'eglot-java)

(setq jdtls-java-debug-plugin-jar
      (file-name-concat (expand-file-name ".")
                        ))

(defun my/eglot-java-init-opts (server eglot-java-eclipse-jdt)
    `(:bundles [,jdtls-java-debug-plugin-jar]))

  (setopt eglot-java-user-init-opts-fn #'my/eglot-java-init-opts)



;; setup dape
(package-install 'dape)
(require 'dape)

(add-to-list 'dape-configs
             `(jdtls
               modes (java-mode java-ts-mode)
               hostname "localhost"
               port (lambda () (eglot-execute-command (eglot-current-server)
                                                      "vscode.java.startDebugSession" nil))
               :request "attach"
               :hostname "localhost"
               :port 8000 ;; Default port exposed by mvnDebug
               :type "java"
               :projectName (lambda () (project-name (project-current)))))
