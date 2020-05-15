;;(Setq debug-on-error t)
(defvar config-dir (file-name-directory (or load-file-name buffer-file-name)))
 
;; Repositories
(require 'package)
(setq package-user-dir (concat config-dir "elpa"))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")
;;                         ("melpa" . "http://melpa.milkbox.net/packages/") ;;this gois down to much
                         ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(package-initialize)
(when (not package-archive-contents)
    (package-refresh-contents))

(defvar my-packages '(tabbar
                      smex
                      nav
                      color-theme
                      fold-dwim
                      pony-mode
                      go-mode
                      go-guru
                      flymake-jshint
                      flymake-csslint
                      ido-ubiquitous 
                      ipython 
                      python-mode
                      pastels-on-dark-theme
                      rainbow-mode
                      rainbow-delimiters
                      color-theme-solarized
                      zenburn-theme 
                      magit
                      helm
                      yasnippet
                      expand-region
                      ycmd
                      company
                      company-ycmd
                      protobuf-mode
                      exec-path-from-shell
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))



;;;;;;;;;;;;;;;;;;;;;;;;; Customizations ;;;;;;;;;;;;;;;;;;;;;;;;;



;; Turn in off paredit mode for JS
(add-hook 'javascript-mode-hook (lambda () (paredit-mode nil)))
;; Fill mode, set 120 columns as default line length
(setq-default fill-column 120)

(add-to-list 'load-path "~/.emacs.d")

(delete-selection-mode 1)
(server-start)

(setq inhibit-startup-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;;turn the bell off
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; show filename in window title
(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;Helm mode defult
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(helm-mode 1)

;;Yegge advice
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\M-s" 'isearch-forward-regexp)
(global-set-key "\M-r" 'isearch-backward-regexp)

;; mute toolbar
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))


;;things to be ported form eclpise:
;; * [x] drag a line
;; * duplilcate a line M-s-up, M-s-down
;; * [x] select containig element; expand region attempt

(defun move-text-internal (arg) 
   (cond 
    ((and mark-active transient-mark-mode) 
     (if (> (point) (mark)) 
        (exchange-point-and-mark)) 
     (let ((column (current-column)) 
          (text (delete-and-extract-region (point) (mark)))) 
       (forward-line arg) 
       (move-to-column column t) 
       (set-mark (point)) 
       (insert text) 
       (exchange-point-and-mark) 
       (setq deactivate-mark nil))) 
    (t 
     (beginning-of-line) 
     (when (or (> arg 0) (not (bobp))) 
       (forward-line) 
       (when (or (< arg 0) (not (eobp))) 
        (transpose-lines arg)) 
       (forward-line -1))))) 
(defun move-text-down (arg) 
   "Move region (transient-mark-mode active) or current line arg lines down." 
   (interactive "*p") 
   (move-text-internal arg)) 
(defun move-text-up (arg) 
   "Move region (transient-mark-mode active) or current line arg lines up." 
   (interactive "*p") 
   (move-text-internal (- arg))) 
(global-set-key [\M-up] 'move-text-up) 
(global-set-key [\M-down] 'move-text-down)

;; expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

;;;; Yasnippet
;;(require 'yasnippet)
;;(yas--initialize)
;;;;(yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets")
;;(yas/global-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3f3f3f" :foreground "#dcdccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Monaco")))))
(put 'downcase-region 'disabled nil)

;; fix indention on RET
(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))



;;;;;;;;;;;;;;;;; Language-specific ;;;;;;;;;;;;;;;;;;;;;;



;;;; Ispell
(setq-default ispell-program-name "/usr/local/bin/ispell")
(setq flyspell-dictionary "russian")
(global-set-key [f9] 'ispell-buffer)

;;;; XML
;;xml pretty-print
(defun xml-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (mark) (point) "xmllint --format -" (buffer-name) t)
  )
)

;;;; Code completion
(with-eval-after-load 'company
  ;;company for completion
  (add-hook 'after-init-hook 'global-company-mode)
  ;; js https://github.com/proofit404/company-tern
  (add-to-list 'company-backends 'company-tern)
  ;; python https://github.com/syohex/emacs-company-jedi
  (add-to-list 'company-backends 'company-jedi)
)

(require 'ycmd)
(add-hook 'after-init-hook #'global-ycmd-mode)

(require 'company-ycmd)
(company-ycmd-setup)


;;;; Vagrant
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;;;; Rails
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

;;;; Gradle
(add-to-list 'auto-mode-alist '("build.gradle$" . groovy-mode))

;;;; Go lang
(setq load-path (cons "/usr/local/opt/go/misc/emacs" load-path))
(require 'go-mode)
(require 'go-guru)

;;;; protobuf
(add-to-list 'auto-mode-alist '(".proto$" . protobuf-mode))

;;;; Clojure
;; from https://github.com/clojure-emacs/cider#auto-completion
;; (setq company-idle-delay nil) ; never start completions automatically
(global-company-mode)
; use meta+tab, aka C-M-i, as manual trigger
(global-set-key (kbd "M-TAB") #'company-indent-or-complete-common) 
;;(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; for cider http://fgiasson.com/blog/index.php/2014/05/22/my-optimal-gnu-emacs-settings-for-developing-clojure-so-far/
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(add-to-list 'same-window-buffer-names "<em>nrepl</em>")
(setq nrepl-popup-stacktraces nil)
(show-paren-mode 1)

;; to get lein from the brew
(add-to-list 'exec-path "/usr/local/bin")


;; to get PATH in GUI same as in zsh
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(add-hook 'paredit-mode-hook
  (lambda ()
    (define-key paredit-mode-map (kbd "<prior>") 'paredit-forward-slurp-sexp)
    (define-key paredit-mode-map (kbd "<next>") 'paredit-backward-slurp-sexp)
    (define-key paredit-mode-map (kbd "<home>") 'paredit-backward-barf-sexp)
    (define-key paredit-mode-map (kbd "<end>") 'paredit-forward-barf-sexp)))


;;;; C++
(load "/usr/local/share/clang/clang-format.el")
(global-set-key [C-M-tab] 'clang-format-region)



;;;; helm for tags
(global-set-key (kbd "M-.") 'helm-etags-select)


;;;;;;;;;;;;;;;;;;;;;;; Visual part ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;(load-theme 'solarized-light)
(load-theme 'zenburn t)
(put 'upcase-region 'disabled nil)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(package-selected-packages
   (quote
    (zenburn-theme yaml-mode web-mode tidy tabbar starter-kit scala-mode rust-mode rainbow-mode rainbow-delimiters python-mode popup pony-mode pastels-on-dark-theme neotree nav ipython helm-delicious helm-core helm-aws groovy-mode go-mode fold-dwim flymake-jshint flymake-csslint expand-region exec-path-from-shell company-tern company-jedi company-go color-theme-solarized coffee-mode clojurescript-mode clojure-snippets cider))))
