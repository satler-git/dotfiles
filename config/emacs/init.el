;;; init.el --- satler's init.el ; -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

; init.el
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
  :bind (:evil-normal-state-map
          :package evil
         ("M-C-t" . tab-bar-new-tab)
         ("C-t" . tab-bar-switch-to-tab))
  :bind (("C-c t" . tab-bar-new-tab)
         ("C-t" . tab-bar-switch-to-tab)
         ("M-0" . tab-bar-switch-to-last-tab)
         ("M-c" . tab-bar-close-tab))
  :custom ((tab-bar-new-tab-choice . "*scratch*"))
  :global-minor-mode t
  :config
  (dotimes (i 9)
    (let ((n (+ i 1)))
      (global-set-key (kbd (format "M-%d" n))
                      `(lambda ()
                         (interactive)
                         (tab-bar-select-tab ,n))))))

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
  :custom (prescient-filter-method . '(fuzzy literal regexp initialism))
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
  :bind (("C-c l" . consult-line) ("C-c b" . consult-buffer) ("C-c w" . consult-ripgrep))
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
    `(add-hook-lambda ,hook
       (require 'reformatter)
       (reformatter-define ,name ,@reformatter-args)
       (,(intern (concat (symbol-name name) "-on-save-mode")) 1)))
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
  (reformatter-hook typst-ts-mode-hook typstyle
    :program "typstyle")
  (reformatter-hook
    '(typescript-ts-mode-hook tsx-ts-mode-hook json-ts-mode-hook) biome
    :program "biome"
    :args `("format" "--stdin-file-path" ,(buffer-file-name))))

(leaf treesit
  :tag "builtin"
  :custom
  ((treesit-font-lock-level . 4))

  :config
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.hledger" . hledger-mode))
  (add-to-list 'auto-mode-alist '("\\.typ\\'" . typst-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml" . yaml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.yml" . yaml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.toml" . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tml" . toml-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.json" . json-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.lua" . lua-ts-mode))
  (add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-ts-mode)))

(reformatter-hook nix-mode-hook nix-format
  :program "nixfmt")
(leaf nix-mode
  :mode "\\.nix\\'"
  :hook
  (nix-ts-mode))

(leaf markdown-mode
  :mode
    (("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'" . markdown-mode) ;; TODO: autoloading したら自動でなるやつ。必要なのこれ?
     ("README\\.md\\'" . gfm-mode))
  :bind (markdown-mode-map
    ("C-c C-e" . markdown-do))
  ;; :config
  ;; (add-to-list 'auto-mode-alist
  ;;   '("\\.\\(?:md\\|markdown\\|mkd\\|mdown\\|mkdn\\|mdwn\\)\\'" . markdown-mode))
  ;; (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
  )

(leaf git-modes
  :commands gitignore-mode gitconfig-mode gitattributes-mode)

(leaf hledger-mode
  :mode ("\\.hledger\\'" "\\.ledger\\'" "\\.journal\\'"))

(reformatter-hook haskell-mode-hook stylish-haskell
  :program "stylish-haskell")
(leaf haskell-mode
  :mode (("\\.[gh]s\\'" . haskell-mode) ;; TODO: autoloading したら自動でなるやつ。必要なのこれ?
        ("\\.hsig\\'" . haskell-mode)
        ("\\.l[gh]s\\'" . haskell-literate-mode)
        ("\\.hsc\\'" . haskell-mode)))

(leaf web-mode
  :commands web-mode
  :mode
  ("\\.[sp]?html\\'"
   "\\.tpl\\.php\\'"
   "\\.jsp\\'"
   "\\.as[cp]x\\'"
   "\\.erb\\'"
   "\\.tsx\\'"
   "\\.js\\'"
   "\\.css\\'"))

(add-to-list 'auto-mode-alist '("\\.sh\\'" . shell-script-mode))

(leaf typst-ts-mode
  :require t
  :commands typst-ts-mode)

(leaf websocket)
(leaf typst-preview
  :require t
  :commands typst-preview-mode
  :custom (typst-preview-browser . "firefox"))

(leaf lsp-mode
  :bind (:evil-normal-state-map
         :package evil
         ("g a" . lsp-execute-code-action)
         ("g d" . xref-find-definitions-other-window)
         ("g n" . lsp-rename))
  :custom
  (lsp-modeline-diagnostics-scope . :workspace)
  (lsp-keymap-prefix . "C-l")
  (lsp-completion-no-cache . t)
  (lsp-completion-provider . :none)
  :hook ((rust-ts-mode-hook . lsp) ;; rust-analyzer
         (typst-ts-mode-hook . lsp) ;; tinymist
         (lua-ts-mode-hook . lsp) ;; lua-language-server
         ((haskell-mode-hook haskell-literate-mode-hook). lsp) ;; haskell-language-server
         (toml-ts-mode-hook . lsp) ;; taplo
         (nix-ts-mode-hook . lsp) ;; nil-ls
         (yaml-ts-mode-hook . lsp) ;; yaml-lang-server
         (json-ts-mode-hook . lsp) ;; json (vsc)
         ((text-mode markdown-mode gfm-mode org-mode prog-mode) . lsp) ;; typos

         (lsp-mode-hook . lsp-enable-which-key-integration)
         (lsp-mode-hook . lsp-headerline-breadcrumb-mode)
         (lsp-mode-hook . flycheck-mode)
         (lsp-configure-hook . lsp-diagnostics-mode))
  :commands lsp
  :config
  (defun lsp-booster--advice-json-parse (old-fn &rest args)
    "Try to parse bytecode instead of json."
    (or
     (when (equal (following-char) ?#)
       (let ((bytecode (read (current-buffer))))
         (when (byte-code-function-p bytecode)
           (funcall bytecode))))
     (apply old-fn args)))
  (advice-add (if (progn (require 'json)
                         (fboundp 'json-parse-buffer))
                  'json-parse-buffer
                'json-read)
              :around
              #'lsp-booster--advice-json-parse)

  (defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
    "Prepend emacs-lsp-booster command to lsp CMD."
    (let ((orig-result (funcall old-fn cmd test?)))
      (if (and (not test?)                             ;; for check lsp-server-present?
               (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
               lsp-use-plists
               (not (functionp 'json-rpc-connection))  ;; native json-rpc
               (executable-find "emacs-lsp-booster"))
          (progn
            (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
              (setcar orig-result command-from-exec-path))
            (message "Using emacs-lsp-booster for %s!" orig-result)
            (cons "emacs-lsp-booster" orig-result))
        orig-result)))
  (advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]vendor")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]target")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\].direnv")

  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "tinymist")
    :major-modes '(typst-ts-mode)
    :server-id 'typst-lsp))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("typos-lsp"))
    :major-modes '(text-mode markdown-mode gfm-mode org-mode prog-mode)
    :server-id 'typos-lsp)))

(leaf lsp-ui
  :commands lsp-ui-mode
  :custom
  ((lsp-ui-doc-enable . t)
   (lsp-ui-doc-position . 'at-point)
   (lsp-ui-doc-show-with-cursor . nil)
   (lsp-ui-doc-show-with-mouse . nil))
  :bind (:lsp-ui-mode-map
    ([remap xref-find-definitions] . lsp-ui-peek-find-definitions) ; (C-l) M-. M-?
    ([remap xref-find-references] . lsp-ui-peek-find-references))
  :bind
  ("C-c x a" . lsp-ui-imenu)
  ("K" . lsp-ui-doc-toggle))

(leaf lsp-haskell)

(leaf lsp-treemacs
  :bind ("C-c x x" . lsp-treemacs-errors-list)
  :commands lsp-treemacs-errors-list)

(leaf consult-lsp)

(leaf flycheck
  :bind ("C-c x f" . flycheck-list-errors)
  :global-minor-mode global-flycheck-mode
  :config
  (add-to-list 'display-buffer-alist
               '("^\\*Flycheck errors\\*"
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . bottom)
                 (slot . 0)
                 (window-height . 10))))

(leaf consult-flycheck)

(leaf yasnippet
  :custom
  (yas-snippet-dirs . '("~/.emacs.d/snippets"))
  :require t
  :global-minor-mode yas-global-mode)

(leaf yasnippet-snippets
 :after yasnippet)

(leaf yasnippet-capf
  :after (yasnippet cape)
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

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
  :pre-setq ((evil-want-integration . t)
             (evil-want-keybinding . nil))
  :custom
  ((evil-undo-system . 'undo-tree)
   (evil-mode-line-format . nil)
   (scroll-preserve-screen-position . t) ;; TODO: 絶対ここじゃない
   (scroll-conservatively . 100)
   (scroll-margin . 3))
  :bind ((:evil-normal-state-map
          ("C-k" . evil-scroll-up)
          ("C-j" . evil-scroll-down)
          ("M" . evil-jump-item)
          (">" . #'my/evil-shift-line-right)
          ("<" . #'my/evil-shift-line-left)
          ("x" . #'my/evil-delete-char)
          ("gcc" . comment-line)
          ("gca" . comment-dwim)
          )
         (:evil-visual-state-map
          (">" . #'my/evil-shift-right-and-keep)
          ("<" . #'my/evil-shift-left-and-keep)
          ("gc" . comment-dwim)
          ("p" . evil-paste-before)
          ("P" . evil-paste-after)
          ("M" . evil-jump-item)
          )
         (:evil-insert-state-map
          ("C-j" . skk-mode))
         )
  :require t
  :config
  (leaf evil-surround
    :require t
    :after evil
    :global-minor-mode global-evil-surround-mode)
  (leaf evil-matchit
    :after evil
    :global-minor-mode global-evil-matchit-mode)
  (leaf evil-collection
    :after evil
    :config
    (evil-collection-init))

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

;; nixpkgs#nerd-fonts.symbols-only
(leaf nerd-icons)

(leaf moody
  :after evil
  :config
  (column-number-mode 1)

  (setq-default mode-line-format '("%e" mode-line-front-space
      (:propertize
       (""
        mode-line-mule-info
        mode-line-client
        mode-line-modified
        mode-line-remote
        mode-line-window-dedicated)
        display (min-width (6.0)))

      (evil-mode-line-tag evil-mode-line-tag)

      mode-line-frame-identification
      mode-line-buffer-identification
      "   "
      mode-line-position
      (project-mode-line project-mode-line-format)
      (vc-mode vc-mode)
      "  "
      mode-line-modes
      mode-line-misc-info
      mode-line-end-spaces))

  (set-face-attribute 'mode-line-active nil
                      :foreground "#a277ff"
                      :background "#15141b"
                      :box 'unspecified)
  (set-face-attribute 'mode-line-inactive nil
                      :foreground "#bdbdbd"
                      :background "#15141b"
                      :box 'unspecified)

  (moody-replace-mode-line-front-space)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

(leaf minions
  :after moody
  :custom (minions-mode-line-lighter . "[+]")
  :config
  (minions-mode))

(leaf dashboard
  :custom
  ((dashboard-banner-logo-title . "Welcome to Emacs")
   (dashboard-center-content . t)
   (dashboard-vertically-center-content . t)
   (dashboard-navigation-cycle . t)
   (dashboard-startup-banner . "~/.emacs.d/etc/dashboard.txt"))
  :config
  (dashboard-setup-startup-hook))

;; 感謝
;; https://naokton.hatenablog.com/entry/2020/12/08/150130

(leaf vterm
  :bind
  (vterm-mode-map
   ("C-q" . vterm-send-next-key))
  :custom
  (vterm-max-scrollback . 10000)
  (vterm-buffer-name-string . "vterm: %s")
  (vterm-keymap-exceptions
   . '("<f1>" "<f2>" "C-c" "C-x" "C-u" "C-g" "C-l" "M-x" "M-o" "C-v" "M-v" "C-y" "M-y")))

(leaf vterm-toggle
  :bind
  ("<f2>" . vterm-toggle)
  (vterm-mode-map
   ([remap projectile-previous-project-buffer]. vterm-toggle-forward)
   ([remap projectile-next-project-buffer] . vterm-toggle-backward))
  :custom
  (vterm-toggle-scope . 'project)
  :config
  ;; Show vterm buffer in the window located at bottom
  (add-to-list 'display-buffer-alist
               '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                 (display-buffer-reuse-window display-buffer-in-direction)
                 (direction . bottom)
                 (reusable-frames . visible)
                 (window-height . 0.4)))
  ;; Above display config affects all vterm command, not only vterm-toggle
  (defun my/vterm-new-buffer-in-current-window()
    (interactive)
    (let ((display-buffer-alist nil))
            (vterm)))
  )

(leaf highlight-indent-guides
  :hook (prog-mode-hook)
  :custom ((highlight-indent-guides-method . 'character) (highlight-indent-guides-auto-enabled . nil))
  :config
  (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray"))


(leaf rainbow-mode
  :hook (css-mode-hook web-mode-hook html-mode-hook js-mode-hook scss-mode-hook emacs-lisp-mode-hook))

(leaf rainbow-delimiters
  :hook (prog-mode-hook))

(leaf hl-todo
  :custom (hl-todo-keyword-faces .
    '(("TODO"   . "#55DDE0")
      ("FIXME"  . "#2081C3")
      ("DEBUG"  . "#F6AE2D")
      ("HACK" . "#F26419")
      ("NOTE" . "#53FF45")
      ("STUB"   . "#F7567C")))
  :global-minor-mode global-hl-todo-mode)

(leaf consult-todo
  :custom (consult-todo--narrow .
    '((?t . "TODO")
      (?f . "FIXME")
      (?d . "DEBUG")
      (?h . "HACK")
      (?n . "NOTE")
      (?s . "STUB")))
  :require t)

(leaf ace-window
  :after evil
  :custom (aw-keys . '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ((:evil-normal-state-map
          :package evil
          ("C-w C-w" . ace-window)
          ("C-w x"   . ace-swap-window))))

(leaf dirvish
  :bind ((:dirvish-mode-map
         ("TAB" . dirvish-subtree-toggle)
         ("C-v" . dirvish-vc-menu)
         (";"   . dired-up-directory)
         ("?"   . dirvish-dispatch)
         ("f"   . dirvish-file-info-menu)
         ("h"   . dired-up-directory)
         ("l"   . dired-find-file)))
  :global-minor-mode dirvish-override-dired-mode
  :config
  (setq dirvish-attributes
    (append
     '(vc-state subtree-state nerd-icons collapse)
     '(file-modes file-time file-size))))

(leaf projectile
  :require t
  :custom
  (projectile-project-search-path . '("~/repos/github.com/satler-git/" "~/repos/github.com/ltrait/" "~/dotfiles"))
  (projectile-cleanup-known-projects . nil)
  :bind
  (:projectile-mode-map
   ("C-c p" . projectile-command-map)
   ("C-." . projectile-next-project-buffer)
   ("C-," . projectile-previous-project-buffer))
  :bind ("C-c f" . projectile-find-file)
  :global-minor-mode projectile-mode
  :config
  (add-to-list 'projectile-globally-ignored-modes "vterm-mode"))

(leaf projectile-ripgrep)

(leaf magit
  :bind
  ("C-c g" . magit-status)
  ("C-c M-g" . magit-dispatch)
  ("C-c C-M-g" . magit-file-dispatch)
  :custom (magit-define-global-key-bindings . nil)
  :config
  (add-to-list 'magit-no-confirm :trash))

(leaf forge
  :after magit
  :custom
  (auth-sources . '("~/.authinfo"))
  (forge-add-default-bindings . nil)
  :require t)

(setq-default indent-tabs-mode nil)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; (add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
;; (load-theme 'aura-soft-dark-soft-text t)

(which-key-mode 1)

(add-hook 'emacs-startup-hook #'electric-pair-mode)
(add-hook 'emacs-startup-hook
          #'(lambda ()
              (fset 'yes-or-no-p 'y-or-n-p)))

(setq display-time-24hr-format t)

(setq echo-keystrokes 0.1)
(setq use-dialog-box nil)

(setopt kill-ring-max 100000)
(setopt recentf-max-saved-items 1000)

(setopt vc-follow-symlinks t)

(custom-set-variables '(savehist-additional-variables '(kill-ring)))

(setq truncate-lines t)
(setq truncate-partial-width-windows t)
(setq show-trailing-whitespace t)

(provide 'init)
