(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf blackout :ensure t)

    :config
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

;;; ######################## ここに各自好きな設定を書く ここから



;;; ######################## ここに各自好きな設定を書く ここまで

;;; 自作モード（sign-mode）の設定

;;; ***** Sign設定 ここから *****
;; 1. 「lisp」フォルダを、Emacsの検索範囲（load-path）に追加する
(add-to-list 'load-path (locate-user-emacs-file "lisp"))

;; 2. sign-mode の読み込みと、ファイル拡張子の紐づけ
;; ※ 拡張子 ".sn" 
(autoload 'sign-mode "sign-mode" "Major mode for sign language." t)
(add-to-list 'auto-mode-alist '("\\.sn\\'" . sign-mode))

;;; ***** Sign設定 ここまで *****


(provide 'init)


