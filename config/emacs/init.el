;; -*- lexical-binding: t -*-

;; init.el
;;
;; takeokunさんなど

;; <leaf-install-code>
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)

  ;; (unless (package-installed-p 'leaf)
  ;;   (package-refresh-contents)
  ;;   (package-install 'leaf))

  (require 'leaf)

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf el-get :ensure t)
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

(leaf cus-start
  :tag "builtin" "internal"
  :custom ((user-full-name . "satler")
           (user-mail-address . "satler@satler.dev")
           (user-login-name . "satler")))

(leaf autorevert
  :doc "revert buffers when files on disk change"
  :global-minor-mode global-auto-revert-mode)

(leaf paren
  :doc "highlight matching paren"
  :global-minor-mode show-paren-mode)

(leaf backup
  :setq ((make-backup-files . nil)
         (auto-save-default . nil)
         (auto-save-list-file-prefix . nil)
         (create-lockfiles . nil)))

(leaf startup
  :doc "process Emacs shell arguments"
  :custom `((auto-save-list-file-prefix . ,(locate-user-emacs-file "backup/.saves-"))))

(leaf savehist
  :doc "Save minibuffer history"
  :custom `((savehist-file . ,(locate-user-emacs-file "savehist")))
  :global-minor-mode t)

(leaf leaf
  :ensure nil
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))


(leaf reformatter
  :ensure t)
;; TODO: rustfmt, stylua, taplo, yaml, json

;; https://github.com/kuuote/nixconf/blob/main/home/emacs/init.org#reformatter
(defmacro add-hook-lambda (hook &rest body)
  (declare (indent defun))
  `(add-hook ',hook (lambda () ,@body)))

(defmacro reformatter-hook (hook name &rest reformatter-args)
  (declare (indent defun))
  `(add-hook-lambda ,hook
     (require 'reformatter) ;; require load reformatter when executed byte compiled function
     (reformatter-define
       ,name
       ,@reformatter-args)
     (, (intern (concat (symbol-name name) "-on-save-mode")) 1)))

;; TODO: syntax highlight by lsp
(leaf treesit
  :tag "builtin"
  :custom
  ((treesit-font-lock-level . 4))

  :config
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.hledger" . hledger-mode)) ;; TODO:
  (add-to-list 'auto-mode-alist '("\\.yaml" . yaml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.yml" . yaml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.toml" . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tml" . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode)))

(reformatter-hook nix-mode-hook nix-format
  :program "nixfmt")
(leaf nix-mode
  :mode "\\.nix\\'"
  :hook
  (nix-ts-mode))

(leaf hledger-mode
  :mode ("\\.hledger\\'" "\\.ledger\\'" "\\.journal\\'"))

;; TODO: typst-ts-mode
;; typst-mode

(set-face-attribute 'default nil :family "Monaspace Argon" :height 112)

(setq display-line-numbers 'relative)
(global-display-line-numbers-mode)

(leaf evil ;; TODO: replace with meow?
  :ensure t
  :require t
  :bind ((:evil-normal-state-map
          ("C-k" . evil-scroll-up)
          ("C-j" . evil-scroll-down)))
  :config
  (evil-mode 1))

(leaf editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(leaf git-gutter ;; TODO: diff-hl ?
  :ensure t
  :require t
  :global-minor-mode global-git-gutter-mode)

(leaf dmacro
  :ensure t
  :custom `((dmacro-key . ,(kbd "C-S-e")))
  :global-minor-mode global-dmacro-mode)

(add-hook 'emacs-startup-hook #'electric-pair-mode)
(add-hook 'emacs-startup-hook
          #'(lambda ()
              (fset 'yes-or-no-p 'y-or-n-p)))

(setq echo-keystrokes 0.1)
(setq use-dialog-box nil)

(setopt kill-ring-max 100000)

(custom-set-variables '(savehist-additional-variables '(kill-ring)))

(setq truncate-lines t)
(setq truncate-partial-width-windows t)

(provide 'init)
