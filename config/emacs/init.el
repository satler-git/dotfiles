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
    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))
;; </leaf-install-code>

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

(leaf cus-start
  :tag "builtin" "internal"
  :custom ((user-full-name . "satler")
           (user-mail-address . "satler@satler.dev")
           (user-login-name . "satler")))

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

(leaf nix-mode
  :mode "\\.nix\\'"
  :hook
  (nix-ts-mode))

(leaf hledger-mode
  :mode ("\\.hledger\\'" "\\.ledger\\'" "\\.journal\\'"))

;; TODO: typst-ts-mode
;; typst-mode

(set-face-attribute 'default nil :family "Monaspace Argon" :height 112)

(defun my/hybrid-line-numbers (line) ;; ChatGPTで生成してみた
  "Return LINE as absolute number on current line, otherwise relative."
  (let ((current (line-number-at-pos)))
    (if (= line current)
        (number-to-string line)
      (number-to-string (abs (- line current))))))

(setq display-line-numbers #'my/hybrid-line-numbers)
(global-display-line-numbers-mode)

(leaf evil ;; TODO: replace with meow?
  :ensure t
  :require t
  :bind ((:evil-normal-state-map
          ("C-k" . evil-scroll-up)
          ("C-j" . evil-scroll-down)))
  :config
  (evil-mode 1))

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

