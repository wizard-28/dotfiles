;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sourajyoti Basak"
      user-mail-address "wiz28@protonmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 22))

(plist-put! +ligatures-extra-symbols
  :and           nil
  :or            nil
  :for           nil
  :some          nil
  :return        nil
  :yield         nil
  :not           nil
  :true          nil
  :false         nil
  :int           nil
  :float         nil
  :str           nil
  :bool          nil
  :list          nil
  :tuple         nil
)

(setq doom-theme 'doom-palenight)

(setq fancy-splash-image (concat (getenv "DOOMDIR") "splash.png"))

(setq display-line-numbers-type 'relative)

(setq doom-modeline-major-mode-icon t)

(after! lsp-mode
  (setq lsp-rust-analyzer-server-display-inlay-hints t))

(after! dap-mode
  (require 'dap-gdb-lldb)
  (dap-register-debug-template "Rust::GDB Run Configuration"
                               (list :type "gdb"
                                     :request "launch"
                                     :name "GDB::Run"
                                     :gdbpath "rust-gdb"
                                     :target nil
                                     :dap-compilation "cargo build"
                                     :dap-compilation-dir "${workspaceFolder}"
                                     :cwd "${workspaceFolder}")))

(setq org-directory "~/org/")

(setq org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

(after! org
  (dolist
      (face
       '((org-level-1 1.7 "#82aaff" ultra-bold)
         (org-level-2 1.6 "#c792ea" extra-bold)
         (org-level-3 1.5 "#c3e88d" bold)
         (org-level-4 1.4 "#ffcb6b" semi-bold)
         (org-level-5 1.3 "#a3f7ff" normal)
         (org-level-6 1.2 "#e1acff" normal)
         (org-level-7 1.1 "#f07178" normal)
         (org-level-8 1.0 "#ddffa7" normal)))
    (set-face-attribute (nth 0 face) nil :font doom-variable-pitch-font :weight (nth 3 face) :height (nth 1 face) :foreground (nth 2 face)))
  (set-face-attribute 'org-table nil :font doom-font :weight 'normal :height 1.0 :foreground "#bfafdf"))

(use-package! org-sticky-header
  :hook (org-mode . org-sticky-header-mode))

(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))

(setq projectile-project-search-path '("~/code/"))

(use-package! elcord
  :config (elcord-mode))

(use-package! evil-snipe
  :config (setq evil-snipe-scope 'visible))

(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

(use-package! topsy :hook (prog-mode . topsy-mode))

;; HACK: https://github.com/emacs-tree-sitter/elisp-tree-sitter/issues/64
(setq-default spell-fu-faces-include
              '(tree-sitter-hl-face:comment
                tree-sitter-hl-face:doc
                tree-sitter-hl-face:string
                font-lock-comment-face
                font-lock-doc-face
                font-lock-string-face))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'org-agenda-mode)))
      (rainbow-mode 1))))

(global-rainbow-mode 1)
