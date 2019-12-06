(use-package
  use-package-ensure-system-package
  :ensure t)

;; ==============================================
;; Evil mode
;; ==============================================
(use-package
  evil
  :config (setq evil-emacs-state-cursor '("#ffb1ef" bar))
  (setq evil-normal-state-cursor '("#55b1ef" box))
  (setq evil-visual-state-cursor '("orange" box))
  (setq evil-insert-state-cursor '("#c46bbc" bar))
  (setq evil-replace-state-cursor '("#c46bbc" hollow-rectangle))
  (setq evil-operator-state-cursor '("#c46bbc" hollow))
  (evil-mode 1)
  :bind (:map evil-insert-state-map
              ("C-g" . evil-normal-state)))
(use-package
  evil-terminal-cursor-changer
  :unless (display-graphic-p)
  :after evil
  :config (evil-terminal-cursor-changer-activate))
(use-package
  evil-leader
  :after evil
  :config (evil-leader/set-leader "SPC")
  (evil-leader/set-key "w" #'evil-window-map)
  (evil-leader/set-key "h" #'evil-first-non-blank)
  (evil-leader/set-key "l" #'evil-end-of-line)
  (global-evil-leader-mode))



;; ==============================================
;; Ivy Counsel Swiper
;; ==============================================
(use-package
  smex)
(use-package
  ivy
  :config (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (eval-after-load "evil-leader" (progn (evil-leader/set-key "SPC" #'counsel-M-x)
                                        (evil-leader/set-key "f f" #'find-file)
                                        (evil-leader/set-key "b b" #'switch-to-buffer)
                                        (evil-leader/set-key "b k" #'kill-buffer)))
  (ivy-mode t))
(use-package
  counsel
  :bind ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-h v" . counsel-describe-variable)
  ("C-h f" . counsel-describe-function)
  ("C-h k" . counsel-describe-function)
  :config (eval-after-load "evil-leader" (progn (evil-leader/set-key "? f"
                                                  #'counsel-describe--function)
                                                (evil-leader/set-key "? v"
                                                  #'counsel-describe--variable)
                                                (evil-leader/set-key "? k"
                                                  #'counsel-describe--key))))
(use-package
  swiper
  :ensure t
  :bind ("C-s" . swiper))


;; Project
;; ==============================================
(use-package
  projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :config (projectile-mode)
  (eval-after-load "evil-leader" (progn (evil-leader/set-key "p" 'projectile-command-map))))
(use-package
  counsel-projectile
  :ensure t
  :after projectile
  :config (counsel-projectile-mode t))
(use-package
  magit
  :ensure t
  :config (eval-after-load "evil-leader" (progn  (evil-leader/set-key "g" 'magit-status))))


;; ==============================================
;; Dired file manager
;; ==============================================
(use-package
  dired
  :ensure nil
  :config

  ;; Always delete and copy recursively
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  ;; Auto refresh Dired, but be quiet about it
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil)

  ;; Quickly copy/move file in Dired
  (setq dired-dwim-target t)

  ;; Move files to trash when deleting
  (setq delete-by-moving-to-trash t)

  ;; Reuse same dired buffer, so doesn't create new buffer each time
  (put 'dired-find-alternate-file 'disabled nil)
  (add-hook 'dired-mode-hook
            (lambda ()
              (local-set-key (kbd "<mouse-2>") #'dired-find-alternate-file)))
  (add-hook 'dired-mode-hook
            (lambda ()
              (local-set-key (kbd "RET") #'dired-find-alternate-file)))
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map (kbd "^")
                (lambda ()
                  (interactive)
                  (find-alternate-file "..")))
              (dired-hide-details-mode t))))




;; ==============================================
;; Theme
;; ==============================================
(use-package
  doom-themes
  :when (display-graphic-p)
  :ensure t
  :config (load-theme 'doom-tomorrow-night t)
  (defun on-frame-open (frame)
    (if (not (display-graphic-p frame))
        (set-face-background 'default "unspecified-bg" frame)))
  (on-frame-open (selected-frame))
  (add-hook 'after-make-frame-functions 'on-frame-open))
;; Modeline theme
(use-package
  doom-modeline
  :ensure t
  :init (doom-modeline-init)
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-height 25 doom-modeline-bar-width 3 doom-modeline-icon nil
                doom-modeline-enable-word-count 10 doom-modeline-icon (display-graphic-p)
                doom-modeline-buffer-file-name-style 'file-name)
  (set-face-attribute 'mode-line nil
                      :background nil)
  (set-face-attribute 'mode-line-inactive nil
                      :background nil))

;; ==============================================
;; Default Enhancement
;; ==============================================


;; ==============================================
;; Default Enhancement
;; ==============================================

(use-package
  windresize
  :ensure t)
(when (fboundp 'winner-mode)
  (winner-mode 1))



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
  :config (setq highlight-indent-guides-method 'character)
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


(provide 'global)
