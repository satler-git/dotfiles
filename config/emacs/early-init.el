;; -*- lexical-binding: t -*-

(setq ring-bell-function 'ignore)

;; native comp

(with-eval-after-load 'comp-run
  (setopt native-comp-async-jobs-number 8)
  (setopt native-comp-speed 3)
  (setopt native-comp-always-compile t))

(with-eval-after-load 'warnings
  (setopt warning-suppress-types '((comp))))

(with-eval-after-load 'time
  (setopt display-time-24hr-format t))

;; disable

(with-eval-after-load 'scroll-bar
  (scroll-bar-mode -1))

(with-eval-after-load 'tool-bar
  (tool-bar-mode -1))

(with-eval-after-load 'menu-bar
  (menu-bar-mode -1))

(setq inhibit-startup-screen t)
