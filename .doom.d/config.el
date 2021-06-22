;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "Sourajyoti Basak"
      user-mail-address "wiz28@protonmail.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/org/")

(setq display-line-numbers-type 'relative)

(setq doom-modeline-icon (display-graphic-p))
(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)

(setq doom-font (font-spec :family "JetBrainsMonoNL Nerd Font Mono" :size 15)
      doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
      doom-big-font (font-spec :family "JetBrainsMonoNL Nerd Font Mono" :size 22))

(add-to-list 'auto-mode-alist '("\\.pacscript\\'" . sh-mode))
