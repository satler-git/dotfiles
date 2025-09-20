;; -*- lexical-binding: t -*-

;; native comp

(with-eval-after-load 'comp-run
  (setopt native-comp-async-jobs-number 8)
  (setopt native-comp-speed 3)
  (setopt native-comp-always-compile t))

(setopt warning-suppress-types '((comp) (native-compiler)))
(setopt native-comp-async-report-warnings-errors nil)

(native-compile-async "~/.emacs.d/early-init.el")
(native-compile-async "~/.emacs.d/init.el")

;; disable

(with-eval-after-load 'scroll-bar
  (scroll-bar-mode -1))

(with-eval-after-load 'tool-bar
  (tool-bar-mode -1))

(with-eval-after-load 'menu-bar
  (menu-bar-mode -1))

(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)

;; GC

(setq gc-cons-threshold (* 10 128 1024 1024))
(setq garbage-collection-messages nil)

(setq read-process-output-max (* 8 1024 1024))
