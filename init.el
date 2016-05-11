;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GENERAL CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(menu-bar-mode -1)

(scroll-bar-mode -1)

(global-linum-mode)

(tool-bar-mode -1)

(show-paren-mode)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backup")))))

(setq vc-make-backup-files t)

(defalias 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGES AND UPDATE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(package-initialize)

(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))

(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))

(setq to-install
      '(
	;; Utils ->
	smex
	neotree
	smooth-scrolling
	ido-vertical-mode
	powerline
	auto-complete

	;; Helpers ->
	google-this
	google-translate
	lorem-ipsum
	eimp

	;; Modes ->
	zencoding-mode
	js2-mode
	php-mode
	json-mode
	skewer-mode
	lua-mode
	haskell-mode
	erlang

	;; Org Mode ->
	ox-twbs
	org-bullets
	
	;; Themes ->
	solarized-theme
	suscolors-theme
	tangotango-theme
	ample-theme
	))

(defun update-emacs()
  "Updating emacs"
  (interactive)
  (package-refresh-contents)
  (mapc 'install-if-needed to-install)
  (message "JOBS DONE!"))

(defun update-fn (switch)
  (update-emacs))

;; Run update if emacs started from shell like "emacs -update"
(add-to-list 'command-switch-alist '("-update" . update-fn))

;; Load packages if emacs running first time
(if (not (file-directory-p "~/.emacs.d/elpa"))
    (update-emacs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; THEME CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(load-theme 'tango-dark t)

;;(require 'solarized-theme)
;;(load-theme 'solarized-dark t)

;;(require 'suscolors-theme)
;;(load-theme 'suscolors t)

(require 'ample-theme)
(load-theme 'ample t)

;;(require 'tangotango-theme)
;;(load-theme 'tangotango t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EIMP CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'image-mode-hook 'eimp-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SMOOTH SCROLLING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smooth-scrolling)

(smooth-scrolling-mode 1)

(setq-default smooth-scroll-margin 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NEOTREE CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'neotree)

(global-set-key [f8] 'neotree-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ZEN CODING CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'zencoding-mode)

(add-hook 'sgml-mode-hook 'zencoding-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IDO CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ido-vertical-mode)

(ido-mode t)

(setq ido-use-faces t)

(set-face-attribute 'ido-vertical-first-match-face nil
                    :background nil
                    :foreground "orange")

(set-face-attribute 'ido-vertical-only-match-face nil
                    :background nil
                    :foreground nil)

(set-face-attribute 'ido-vertical-match-face nil
                    :foreground nil)

(ido-vertical-mode t)

(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(setq ido-vertical-show-count t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SKEWER CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SMEX CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUTO COMPLETE CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete)
(global-auto-complete-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'php-mode)
(add-hook 'php-mode-hook 'my-php-mode-hook)

(defun my-php-mode-hook ()
  (setq indent-tabs-mode t)
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (setq c-basic-indent my-tab-width)
    (set (make-local-variable 'tab-stop-list)
         (number-sequence my-tab-width 200 my-tab-width))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GOOGLE-THIS-CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(google-this-mode 1)
(global-set-key (kbd "C-x g") 'google-this-mode-submap)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GOOGLE TRANSLATE CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; POWERLINE CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'powerline)
(powerline-center-theme)
(set-face-attribute 'mode-line nil
                    :foreground "White"
                    :background "DarkOrange"
                    :box nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODE CONFIG
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'org-bullets)
(add-hook 'org-mode-hook
	  (lambda ()
	    (org-bullets-mode t)))

;; Change collapse type
(setq org-ellipsis " ⮷")

;; Only one star per level
(setq org-hide-leading-stars t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

(setq org-export-html-postamble-format 
      '(("en" "<p class=\"postamble\">Last Updated %d. Created by %c</p>")))

(defun org-add-class(classname)
  (interactive "sClass Name:")
  (insert (concat"#+attr_html: :class " classname)))

(defun org-add-attr(key val)
  (interactive "sAttr Key:\nsAttr Val:")
  (if (string= "" val)
      (insert (concat "#+attr_html: :" key " \"\""))
    (insert (concat "#+attr_html: :" key " " val))))

(setq org-footnote-definition-re "^\\[fn:[-_[:word:]]+\\]"
      org-footnote-re            (concat "\\[\\(?:fn:\\([-_[:word:]]+\\)?:"
                                         "\\|"
                                         "\\(fn:[-_[:word:]]+\\)\\)"))

(org-defkey org-mode-map (kbd "C-c h") 'org-html-export-to-html)
(org-defkey org-mode-map (kbd "C-c p") 'org-latex-export-to-pdf)
(org-defkey org-mode-map (kbd "C-c c") 'org-add-class)
(org-defkey org-mode-map (kbd "C-c a") 'org-add-attr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun add-comment(name)
  "Adds elisp comment section"
  (interactive "sComment Section Name:")
  (insert
   (concat
    ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n"
    ";; " (upcase name) "\n"
    ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;")))

(defun move-line-up()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

;;(defun get-cdn(package)
;;  "Adds cdn item to item"
;;  (interactive "sLibrary Name:")
;;  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADVICES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CUSTOM KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "M-<up>") 'move-line-up)

(global-set-key (kbd "M-<down>") 'move-line-down)

(global-set-key (kbd "C-c C-a") 'add-comment)

(global-set-key (kbd "C-c C-k") 'compile)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; OS SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (eq system-type 'windows-nt)
  (add-to-list 'default-frame-alist '(font . "Droid Sans Mono-11" ))
  (set-face-attribute 'default t :font "Droid Sans Mono-11" ))

(when (eq system-type 'darwin)
  (message "MACOSX"))

(when (eq system-type 'gnu/linux)
  (message "Linux"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TODO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SGML KEYBINDINGS
;; TRAMP MODE SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
