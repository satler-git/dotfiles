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

  (require 'leaf)

  (leaf leaf-keywords
    :config
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

(leaf tab-bar-mode
  :bind (("C-c t" . tab-bar-new-tab)
         ("C-c g" . tab-bar-switch-to-tab)
	 ("C-c n" . tab-bar-switch-to-next-tab)
	 ("C-c p" . tab-bar-switch-to-prev-tab) ;; TODO: embark?を導入したら
	 ("C-c 0" . tab-bar-switch-to-last-tab)
	 ("M-c" . tab-bar-close-tab))
  :custom ((tab-bar-new-tab-choice . "*scratch*"))
  :global-minor-mode t)

(leaf leaf
  :config
  (leaf leaf-convert)
  (leaf leaf-tree
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

(leaf macrostep
  :bind (("C-c e" . macrostep-expand) ("C-c r" . macrostep-collapse)))

(leaf vertico
  :require vertico-directory
  :custom
  ((vertico-cycle . t) (vertico-count . 20))
  :init
  (vertico-mode))

(leaf prescient
  :global-minor-mode prescient-persist-mode)

(leaf vertico-prescient
  :after vertico prescient
  :global-minor-mode vertico-prescient-mode)

(leaf marginalia
  :init
  (marginalia-mode))

(leaf orderless
  :after t
  :custom
  ((completion-styles . '(orderless basic))
   (completion-category-defaults . nil)))

(leaf embark
  :bind (("M-e" . embark-act))) ;; -> C-h

(defun my/vc-root-dir-or-def ()
  (or
    (vc-root-dir)
    default-directory))

(setq consult-project-root-function #'my/vc-root-dir-or-def)

(leaf consult
  :bind (("C-c l" . consult-line) ("C-c b" . consult-buffer))
  :custom ((consult-find-command . "fd --color=never --full-path ARG OPTS") ))

(leaf embark-consult
  :after embark consult
  :require t
  :bind ((:minibuffer-mode-map
          ("M-." . embark-dwin)
          ("M-e" . embark-act))))

(leaf consult-dir
  :after consult
  :bind (("C-x C-d" . consult-dir)
	 (vertico-map
	  ("C-x C-d" . consult-dir)
	  ("C-x C-j" . consult-dir-jump-file))))

(leaf affe
  :bind (("C-c f" . affe-find))
  :custom ((affe-highlight-function . 'orderless-highlight-matches)
	 (affe-regexp-function . 'orderless-pattern-compiler)
	 (affe-find-command . "fd --color=never --full-path")))

(leaf corfu
  :bind ((corfu-map ("C-e" . corfu-quit)) ())

  :custom
  ((corfu-cycle . t)
  (corfu-quit-at-boundary . nil)
  (corfu-quit-no-match . 'separator)
  (corfu-auto . t))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(leaf corfu-prescient
  :after corfu prescient
  :global-minor-mode corfu-prescient-mode)

(leaf cape
  :after corfu
  :init
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  (add-hook 'completion-at-point-functions #'cape-elisp-symbol)
  (add-hook 'completion-at-point-functions #'cape-emoji))

(leaf kind-icon
  :after corfu
  :custom (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(leaf emacs
  :custom
  ((tab-always-indent . 'complete)
  (text-mode-ispell-word-completion . nil)
  (read-extended-command-predicate . #'command-completion-default-include-p)))

(leaf ddskk
  :bind (("C-c j" . skk-mode)))

;; original by https://github.com/kuuote/nixconf/blob/main/home/emacs/init.org#reformatter
;; generated with ChatGPT {{
(defmacro add-hook-lambda (hook &rest body)
  (declare (indent defun))
  (cond
   ;; 引用されたリスト: '(a b)
   ((and (listp hook) (eq (car hook) 'quote))
    (let ((hooks (cadr hook)))
      `(progn
         ,@(mapcar (lambda (h)
                     `(add-hook ',h (lambda () ,@body)))
                   hooks))))
   ;; ただのリスト: (a b)
   ((listp hook)
    `(progn
       ,@(mapcar (lambda (h)
                   `(add-hook ',h (lambda () ,@body)))
                 hook)))
   ;; 単一シンボル
   (t
    `(add-hook ',hook (lambda () ,@body)))))

(defmacro reformatter-hook (hook name &rest reformatter-args)
  (declare (indent defun))
  (let ((mode-fn (intern (concat (symbol-name name) "-on-save-mode"))))
    `(add-hook-lambda ,hook
       (require 'reformatter)
       (reformatter-define ,name ,@reformatter-args)
       (,mode-fn 1))))
;; }}

(leaf reformatter
  :config
  (reformatter-hook rust-ts-mode-hook rustfmt
    :program "rustfmt"
    :args '("--color" "never" "--quiet"))
  (reformatter-hook lua-ts-mode-hook stylua
    :program "stylua"
    :args '("-"))
  (reformatter-hook toml-ts-mode-hook taplo
    :program "taplo"
    :args '("fmt"))
  (reformatter-hook yaml-ts-mode-hook yamlfmt
    :program "yamlfmt"
    :args '("-in"))
  (reformatter-hook
    '(typescript-ts-mode-hook tsx-ts-mode-hook json-ts-mode-hook) biome
    :program "biome"
    :args `("format" "--stdin-file-path" ,(buffer-file-name))))

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
  (add-to-list 'auto-mode-alist '("\\.json" . json-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.lua" . lua-ts-mode))
  (add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode)))

(leaf rainbow-mode
  :hook (css-mode-hook web-mode-hook html-mode-hook js-mode-hook scss-mode-hook emacs-lisp-mode-hook))

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

(leaf undo-tree
  :require t
  :config
  (let ((undo-dir "~/.emacs.d/undo"))
    (unless (file-exists-p undo-dir)
	(make-directory undo-dir t))
    (setq undo-tree-history-directory-alist `((".*" . ,undo-dir))))
  (global-undo-tree-mode))

(add-to-list 'display-buffer-alist
  '("\\*undo-tree\\*"
    (display-buffer-in-side-window)
    (side . right)
    (window-width . 0.25)))

(defun my/evil-shift-right-and-keep ()
  (interactive)
  (evil-shift-right (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore)
)

(defun my/evil-shift-left-and-keep ()
  (interactive)
  (evil-shift-left (region-beginning) (region-end))
  (evil-normal-state)
  (evil-visual-restore)
)

(defun my/evil-shift-line-left ()
  (interactive)
  (evil-shift-left (line-beginning-position) (line-end-position))
)

(defun my/evil-shift-line-right ()
  (interactive)
  (evil-shift-right (line-beginning-position) (line-end-position))
)

(defun my/evil-delete-char ()
  (interactive)
  (let ((pos (point)))
    (delete-char 1))
)

(leaf evil ;; TODO: replace with meow?
  :require t
  :custom
  ((evil-undo-system . 'undo-tree))
  :bind ((:evil-normal-state-map
          ("C-k" . evil-scroll-up)
          ("C-j" . evil-scroll-down)
          ("M" . evil-jump-item)
	  (">" . #'my/evil-shift-line-right)
	  ("<" . #'my/evil-shift-line-left))
	  ("x" . #'my/evil-delete-char)
	 (:evil-visual-state-map
	  (">" . #'my/evil-shift-right-and-keep)
	  ("<" . #'my/evil-shift-left-and-keep)))
  :config
  (leaf evil-surround
    :require t
    :global-minor-mode global-evil-surround-mode)
  (evil-mode 1))

(leaf editorconfig
  :config
  (setq safe-local-variable-directories
    `(,(expand-file-name "~/dotfiles/")
      ,(expand-file-name "~/repos/github.com/satler-git/")
      ,(expand-file-name "~/repos/github.com/ltrait/")))
  (editorconfig-mode 1))

(leaf git-gutter ;; TODO: diff-hl ?
  :require t
  :global-minor-mode global-git-gutter-mode)

(leaf dmacro
  :custom `((dmacro-key . ,(kbd "C-S-e")))
  :global-minor-mode global-dmacro-mode)

(leaf wakatime-mode
  :global-minor-mode global-wakatime-mode)

(leaf envrc
  :commands envrc-global-mode
  :hook ((after-init-hook . envrc-global-mode)))

(leaf ghub)
;; nixpkgs#nerd-fonts.symbols-only
(leaf nerd-icons)

(leaf doom-modeline
  :require nerd-icons
  :custom ((doom-modeline-github . t)
	   `(doom-modeline-github-interval . ,(* 15 60))
	   (doom-modeline-always-show-macro-register . t))
  :hook (after-init-hook))

(leaf dashboard
  :custom
  ((dashboard-banner-logo-title . "Welcome to Emacs")
   (dashboard-center-content . t)
   (dashboard-vertically-center-content . t)
   (dashboard-navigation-cycle . t)
   (dashboard-startup-banner . "~/.emacs.d/etc/dashboard.txt"))
  :config
  (dashboard-setup-startup-hook))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; (add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
;; (load-theme 'aura-soft-dark-soft-text t)

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

(defun my/apply-gui-settings (frame)
  (when (display-graphic-p frame)
    (with-selected-frame frame
      (set-face-attribute 'default nil :family "Monaspace Argon" :height 120)

      (set-fontset-font t 'japanese-jisx0208 (font-spec :family "IBM Plex Sans JP") nil 'append)
      (set-fontset-font t 'katakana-jisx0201 (font-spec :family "IBM Plex Sans JP") nil 'append))))

(add-hook 'after-make-frame-functions #'my/apply-gui-settings)

(when (display-graphic-p)
  (my/apply-gui-settings (selected-frame)))

(provide 'init)
