;;; package -- global
;;; Commentary:
;;; Code:
;; ;; ==============================================
;; Project
;; ==============================================
(use-package
  projectile
  :ensure t
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config (projectile-mode)
  (when (package-installed-p 'evil-leader)
    (evil-leader/set-key "p" 'projectile-command-map)))
(use-package
  counsel-projectile
  :ensure t
  :after (projectile)
  :config (counsel-projectile-mode t))
(use-package
  magit
  :ensure t
  :config (evil-leader/set-key "g" 'magit-status))


;; ==============================================
;; Ivy Counsel Swiper
;; ==============================================
(use-package
  smex
  :ensure t)
(use-package
  ivy
  :ensure t
  :config (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (ivy-mode t))
(use-package
  counsel
  :ensure t
  :bind ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-h v" . counsel-describe-variable)
  ("C-h f" . counsel-describe-function))
(use-package
  swiper
  :ensure t
  :bind ("C-s" . swiper)
  :config (evil-leader/set-key "s" 'swiper))

;; ==============================================
;; Theme
;; ==============================================
(use-package
  doom-themes
  :ensure t
  :config
  (if window-system
      (load-theme 'doom-one t)
    (progn
      (load-theme 'doom-tomorrow-night t)
      (defun on-frame-open (frame)
        (if (not (display-graphic-p frame))
            (set-face-background 'default "unspecified-bg" frame)))
      (on-frame-open (selected-frame))
      (add-hook 'after-make-frame-functions 'on-frame-open)))
  )
;; Modeline theme
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-init)
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-height 2
                doom-modeline-bar-width 3
                doom-modeline-icon nil
                doom-modeline-enable-word-count 10
                doom-modeline-buffer-file-name-style 'file-name)
(set-face-attribute 'mode-line nil :height 180)
(set-face-attribute 'mode-line-inactive nil :height 180))

;; ==============================================
;; Default Enhancement
;; ==============================================

(use-package
  windresize
  :ensure t)
(when (fboundp 'winner-mode)
  (winner-mode 1))
;; Auto complete
(use-package
  company
  :ensure t
  :init
  ;; Don't convert to downcase.
  (setq-default company-dabbrev-downcase nil)
  :config (global-company-mode nil)
  :bind (("C-SPC" . company-complete)
         :map company-active-map ("C-n" . company-select-next)
         ("C-p" . company-select-previous)))
(use-package
  company-statistics
  :ensure t
  :after company
  :config (company-statistics-mode))

(use-package
  yasnippet
  :ensure t
  :config (yas-reload-all)
  (add-hook 'prog-mode-hook (lambda ()
                              (setq company-backends
                                    '((company-yasnippet company-lsp) company-dabbrev-code
                                      company-dabbrev
                                      company-files))))
  :hook (prog-mode . yas-minor-mode))
(use-package
  yasnippet-snippets
  :ensure t
  :after (yasnippet))
(use-package
  ace-jump-mode
  :ensure t
  :after evil-leader
  :config (evil-leader/set-key "j" 'ace-jump-mode))

(use-package
  which-key
  :ensure t
  :defer 1
  :config (setq which-key-idle-delay 0.01)
  (setq which-key-idle-secondary-delay 0)
  (which-key-mode t))

(use-package
  undo-tree
  :ensure t
  :config (global-undo-tree-mode))

;; Better delete
(use-package
  hungry-delete
  :ensure t
  :defer 1
  :config (global-hungry-delete-mode))

;; Highlight indent
(use-package
  highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character)
  ;; (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-delay 0)
  (setq highlight-indent-guides-auto-character-face-perc 7)
  :hook (prog-mode . highlight-indent-guides-mode))
;; Auto complete parentheses
(use-package
  autopair
  :ensure t
  :config (autopair-global-mode))
;; Rainbow parentheses
(use-package
  rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))
;; Highlight parentheses
(use-package
  highlight-parentheses
  :ensure t
  :hook (prog-mode . highlight-parentheses-mode))
(use-package
  multi-term
  :ensure t
  :config (setq multi-term-dedicated-select-after-open-p t)
  :bind ("C-`" . multi-term-dedicated-toggle))

;; macOS
(use-package
  exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config (exec-path-from-shell-initialize))

(provide 'global)
;;; global.el ends here