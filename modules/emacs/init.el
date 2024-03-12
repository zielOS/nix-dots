;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; note: if you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering
  :ensure t
  :config
  (setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(setq native-comp-async-report-warnings-errors nil)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :ensure t
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

(column-number-mode)

;; Set frame transparency
;; Make frame transparency overridable
(defvar efs/frame-transparency '(96 . 96))

(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(delete-selection-mode 1)
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-visual-line-mode t)  ;; Enable truncated lines

(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.
(setq use-file-dialog nil)   ;; No file dialog
(setq use-dialog-box nil)    ;; No dialog box
(setq pop-up-windows nil)    ;; No popup windows
(setq auto-save-visited-mode t)

(use-package cape
  :ensure t
  :init 
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
  
  (defun crafted-completion-corfu-eshell ()
    "Special settings for when using corfu with eshell."
    (setq-local corfu-quit-at-boundary t
                corfu-quit-no-match t
                corfu-auto nil)
    (corfu-mode))
  (add-hook 'eshell-mode-hook #'crafted-completion-corfu-eshell))

(use-package consult
  :ensure t 
  :init
  (setq completion-in-region-function #'consult-completion-in-region)
  (keymap-global-set "C-s" 'consult-line)
  (keymap-set minibuffer-local-map "C-r" 'consult-history))

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t) 
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-preselect 'prompt) 
  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode))

(use-package dashboard
  :ensure t
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/.config/emacs/art/ascii.txt")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
				      (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package diminish
  :ensure t)

(use-package dired-open
  :ensure t
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package peep-dired
  :ensure t
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
)

 (use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix " ")
  (setq dired-sidebar-theme 'all-the-icons)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(use-package dirvish
  :ensure t
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
     ("m" "/mnt/"                       "Drives")
     ("t" "~/.local/share/Trash/files/" "TrashCan")))
  :config
  ;; (dirvish-peek-mode) ; Preview files in minibuffer
  ;; (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(file-time file-size collapse subtree-state vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))

(use-package drag-stuff
  :ensure t
  :init
  (drag-stuff-global-mode 1)
  (drag-stuff-define-keys))

(use-package eglot
  :ensure t)

(use-package embark
  :ensure t

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(defun efs/evil-hook ()
  (dolist (mode '(custom-mode
                  eshell-mode
                  git-rebase-mode
                  sauron-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :ensure t
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t  ;; This is optional since it's already set to t by default.
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-undo-system 'undo-redo)  ;; Adds vim-like C-r redo functionality
    :config
    (add-hook 'evil-mode-hook 'efs/evil-hook)
    (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  ;; Do not uncomment this unless you want to specify each and every mode
  ;; that evil-collection should works with.  The following line is here
  ;; for documentation purposes in case you need it.
  ;; (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer))
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

;; Using RETURN to follow links in Org/Evil
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

(defun efs/set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 135)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font" :height 135)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "JetBrainsMono Nerd Font" :height 135 :weight 'regular))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (setq doom-modeline-icon t)
                (with-selected-frame frame
                  (efs/set-font-faces))))
  (efs/set-font-faces))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package general
  :ensure t
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer efs/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

(efs/leader-keys
 "SPC" '(execute-extended-command :wk "M-x")
 "f f" '(find-file :wk "find file")
  "=" '(perspective-map :wk "perspective") ;; lists all the perspective keybindings
 "/" '(comment-line :wk "comment lines")
 "u" '(universal-argument :wk "universal argument"))

(efs/leader-keys
 "b" '(:ignore t :wk "Bookmarks/Buffers")
 "b b" '(switch-to-buffer :wk "Switch to buffer")
 "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
 "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
 "b d" '(bookmark-delete :wk "Delete bookmark")
 "b i" '(ibuffer :wk "Ibuffer")
 "b k" '(kill-current-buffer :wk "Kill current buffer")
 "b K" '(kill-some-buffers :wk "Kill multiple buffers")
 "b l" '(list-bookmarks :wk "List bookmarks")
 "b m" '(bookmark-set :wk "Set bookmark")
 "b n" '(next-buffer :wk "Next buffer")
 "b p" '(previous-buffer :wk "Previous buffer")
 "b r" '(revert-buffer :wk "Reload buffer")
 "b R" '(rename-buffer :wk "Rename buffer")
 "b s" '(basic-save-buffer :wk "Save buffer")
 "b S" '(save-some-buffers :wk "Save multiple buffers")
 "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

(efs/leader-keys
 "d" '(:ignore t :wk "Dired")
 "d e" '(dirvish-side :wk "Toggle dired sidebar")
 "d d" '(dired :wk "Open dired")
 "d f" '(wdired-finish-edit :wk "Writable dired finish edit")
 "d j" '(dired-jump :wk "Dired jump to current")
 "d n" '(neotree-dir :wk "Open directory in neotree")
 "d p" '(peep-dired :wk "Peep-dired")
 "d w" '(wdired-change-to-wdired-mode :wk "Writable dired"))

(efs/leader-keys
 "e" '(:ignore t :wk "Ediff/Eshell/Eval/EWW")
 "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
 "e d" '(eval-defun :wk "Evaluate defun containing or after point")
 "e e" '(eval-expression :wk "Evaluate and elisp expression")
 "e f" '(ediff-files :wk "Run ediff on a pair of files")
 "e F" '(ediff-files3 :wk "Run ediff on three files")
 "e h" '(counsel-esh-history :which-key "Eshell history")
 "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
 "e r" '(eval-region :wk "Evaluate elisp in region")
 "e R" '(eww-reload :which-key "Reload current page in EWW")
 "e s" '(eshell :which-key "Eshell"))

(efs/leader-keys
 "f" '(:ignore t :wk "Files")
 "f c" '((lambda () (interactive)
           (find-file "~/.config/emacs/config.org"))
         :wk "Open emacs config.org")
 "f p" '((lambda () (interactive)
           (dired "~/.config/emacs/"))
         :wk "Open user-emacs-directory in dired")
 "f d" '(find-grep-dired :wk "Search for string in files in DIR")
 "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
 "f i" '((lambda () (interactive)
           (find-file "~/.config/emacs/init.el"))
         :wk "Open emacs init.el")
 "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
 "f l" '(counsel-locate :wk "Locate a file")
 "f r" '(counsel-recentf :wk "Find recent files")
 "f u" '(sudo-edit-find-file :wk "Sudo find file")
 "f U" '(sudo-edit :wk "Sudo edit file"))

(efs/leader-keys
 "h" '(:ignore t :wk "Help")
 "h a" '(counsel-apropos :wk "Apropos")
 "h b" '(describe-bindings :wk "Describe bindings")
 "h c" '(describe-char :wk "Describe character under cursor")
 "h d" '(:ignore t :wk "Emacs documentation")
 "h d a" '(about-emacs :wk "About Emacs")
 "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
 "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
 "h d m" '(info-emacs-manual :wk "The Emacs manual")
 "h d n" '(view-emacs-news :wk "View Emacs news")
 "h d o" '(describe-distribution :wk "How to obtain Emacs")
 "h d p" '(view-emacs-problems :wk "View Emacs problems")
 "h d t" '(view-emacs-todo :wk "View Emacs todo")
 "h d w" '(describe-no-warranty :wk "Describe no warranty")
 "h e" '(view-echo-area-messages :wk "View echo area messages")
 "h f" '(describe-function :wk "Describe function")
 "h F" '(describe-face :wk "Describe face")
 "h g" '(describe-gnu-project :wk "Describe GNU Project")
 "h i" '(info :wk "Info")
 "h I" '(describe-input-method :wk "Describe input method")
 "h k" '(describe-key :wk "Describe key")
 "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
 "h L" '(describe-language-environment :wk "Describe language environment")
 "h m" '(describe-mode :wk "Describe mode")
 "h r" '(:ignore t :wk "Reload")
 "h r r" '((lambda () (interactive)
             (load-file "~/.config/emacs/init.el"))
           :wk "Reload emacs config")
 "h t" '(load-theme :wk "Load theme")
 "h v" '(describe-variable :wk "Describe variable")
 "h w" '(where-is :wk "Prints keybinding for command if set")
 "h x" '(describe-command :wk "Display full documentation for command"))

(efs/leader-keys
 "m" '(:ignore t :wk "Org")
 "m a" '(org-agenda :wk "Org agenda")
 "m e" '(org-export-dispatch :wk "Org export dispatch")
 "m i" '(org-toggle-item :wk "Org toggle item")
 "m t" '(org-todo :wk "Org todo")
 "m b" '(org-babel-tangle :wk "Org babel tangle")
 "m T" '(org-todo-list :wk "Org todo list"))

(efs/leader-keys
 "m d" '(:ignore t :wk "Date/deadline")
 "m d t" '(org-time-stamp :wk "Org time stamp"))

(efs/leader-keys
 "o" '(:ignore t :wk "Open")
 "o d" '(dashboard-open :wk "Dashboard")
 "o f" '(make-frame :wk "Open buffer in new frame")
 "o F" '(select-frame-by-name :wk "Select frame by name"))

;; projectile-command-map already has a ton of bindings
;; set for us, so no need to specify each individually.
(efs/leader-keys
 "p" '(projectile-command-map :wk "Projectile"))

(efs/leader-keys
 "s" '(:ignore t :wk "Search")
 "s d" '(dictionary-search :wk "Search dictionary")
 "s m" '(man :wk "Man pages")
 "s o" '(pdf-occur :wk "Pdf search lines matching STRING")
 "s t" '(tldr :wk "Lookup TLDR docs for a command")
 "s w" '(woman :wk "Similar to man but doesn't require man"))

(efs/leader-keys
 "t" '(:ignore t :wk "Toggle")
 "t e" '(eshell-toggle :wk "Toggle eshell")
 "t f" '(flycheck-mode :wk "Toggle flycheck")
 "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
 "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
 "t o" '(org-mode :wk "Toggle org mode")
 "t r" '(rainbow-mode :wk "Toggle rainbow mode")
 "t t" '(visual-line-mode :wk "Toggle truncated lines")
 "t v" '(vterm-toggle :wk "Toggle vterm"))

(efs/leader-keys
 "w" '(:ignore t :wk "Windows/Words")
 ;; Window splits
 "w c" '(evil-window-delete :wk "Close window")
 "w n" '(evil-window-new :wk "New window")
 "w s" '(evil-window-split :wk "Horizontal split window")
 "w v" '(evil-window-vsplit :wk "Vertical split window")
 ;; Window motions
 "w h" '(evil-window-left :wk "Window left")
 "w j" '(evil-window-down :wk "Window down")
 "w k" '(evil-window-up :wk "Window up")
 "w l" '(evil-window-right :wk "Window right")
 "w w" '(evil-window-next :wk "Goto next window")
 ;; Move Windows
 "w H" '(buf-move-left :wk "Buffer move left")
 "w J" '(buf-move-down :wk "Buffer move down")
 "w K" '(buf-move-up :wk "Buffer move up")
 "w L" '(buf-move-right :wk "Buffer move right")
 ;; Words
 "w d" '(downcase-word :wk "Downcase word")
 "w u" '(upcase-word :wk "Upcase word")
 "w =" '(count-words :wk "Count words/lines for buffer"))
)

(use-package git-timemachine
  :ensure t
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)

(use-package magit
  :ensure t)

(use-package hl-todo
  :ensure t
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package aggressive-indent
  :ensure t
  :hook ((nix-mode . aggressive-indent-mode)
	 (python-mode . aggressive-indent-mode)))

(global-display-line-numbers-mode -1)

(setq-default display-line-numbers-grow-only t
              display-line-numbers-width 2)

;; Enable line numbers for some modes
(dolist (mode '(prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode t))))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))

(use-package marginalia
  :after vertico
  :ensure t
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode 1))

(ensure-use-package 'nerd-icons-completion)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles partial-completion)))))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "JetBrainsMono Nerd Font" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(use-package org
  :commands (org-capture org-agenda)
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
    (setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

    (setq org-refile-targets
      '(("Archive.org" :maxlevel . 1)
        ("Tasks.org" :maxlevel . 1)))

    ;; Save Org buffers after refiling!
    (advice-add 'org-refile :after 'org-save-all-org-buffers)
    (setq org-tag-alist
      '((:startgroup)
         ; Put mutually exclusive tags here
         (:endgroup)
         ("@errand" . ?E)
         ("@home" . ?H)
         ("@work" . ?W)
         ("agenda" . ?a)
         ("planning" . ?p)
         ("publish" . ?P)
         ("batch" . ?b)
         ("note" . ?n)
         ("idea" . ?i)))

    ;; Configure custom agenda views
    (setq org-agenda-custom-commands
     '(("d" "Dashboard"
       ((agenda "" ((org-deadline-warning-days 7)))
        (todo "NEXT"
          ((org-agenda-overriding-header "Next Tasks")))
        (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

      ("n" "Next Tasks"
       ((todo "NEXT"
          ((org-agenda-overriding-header "Next Tasks")))))

      ("W" "Work Tasks" tags-todo "+work-email")

      ;; Low-effort next actions
      ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
       ((org-agenda-overriding-header "Low Effort Tasks")
        (org-agenda-max-todos 20)
        (org-agenda-files org-agenda-files)))

      ("w" "Workflow Status"
       ((todo "WAIT"
              ((org-agenda-overriding-header "Waiting on External")
               (org-agenda-files org-agenda-files)))
        (todo "REVIEW"
              ((org-agenda-overriding-header "In Review")
               (org-agenda-files org-agenda-files)))
        (todo "PLAN"
              ((org-agenda-overriding-header "In Planning")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "BACKLOG"
              ((org-agenda-overriding-header "Project Backlog")
               (org-agenda-todo-list-sublevels nil)
               (org-agenda-files org-agenda-files)))
        (todo "READY"
              ((org-agenda-overriding-header "Ready for Work")
               (org-agenda-files org-agenda-files)))
        (todo "ACTIVE"
              ((org-agenda-overriding-header "Active Projects")
               (org-agenda-files org-agenda-files)))
        (todo "COMPLETED"
              ((org-agenda-overriding-header "Completed Projects")
               (org-agenda-files org-agenda-files)))
        (todo "CANC"
              ((org-agenda-overriding-header "Cancelled Projects")
               (org-agenda-files org-agenda-files)))))))

    (setq org-capture-templates
      `(("t" "Tasks / Projects")
        ("tt" "Task" entry (file+olp "~/org/Tasks.org" "Inbox")
             "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

        ("j" "Journal Entries")
        ("jj" "Journal" entry
             (file+olp+datetree "~/org/Journal.org")
             "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
             ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
             :clock-in :clock-resume
             :empty-lines 1)
        ("jm" "Meeting" entry
             (file+olp+datetree "~/org/Journal.org")
             "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
             :clock-in :clock-resume
             :empty-lines 1)

        ("w" "Workflows")
        ("we" "Checking Email" entry (file+olp+datetree "~/org/Journal.org")
             "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

        ("m" "Metrics Capture")
        ("mw" "Weight" table-line (file+headline "~/org/Metrics.org" "Weight")
         "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

    (define-key global-map (kbd "C-c j")
      (lambda () (interactive) (org-capture nil "jj")))

    (efs/org-font-setup)

)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(setq org-confirm-babel-evaluate nil
      org-confirm-elisp-link-function nil
      org-link-shell-confirm-function nil)

(with-eval-after-load 'org
  (org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . t)
      (python . t)
      (shell . t)
      (org . t)
      (jupyter . t)
      (latex . t)
      (sqlite . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("py" . "src jupyter-python")))

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

(setq org-src-preserve-indentation t)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

(use-package pdf-tools
  :ensure t
  :defer t
  :commands (pdf-loader-install)
  :mode "\\.pdf\\'"
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))

(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(use-package elpy
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :ensure t
  :diminish
  :hook org-mode prog-mode)

(use-package savehist
  :ensure t
  :init
  (savehist-mode))

(use-package vterm
  :ensure t
  :config
  (setq shell-file-name "/usr/bin/zsh"
        vterm-max-scrollback 5000))

(use-package vterm-toggle
  :ensure t
  :after vterm
  :config
  ;; When running programs in Vterm and in 'normal' mode, make sure that ESC
  ;; kills the program as it would in most standard terminal programs.
  (evil-define-key 'normal vterm-mode-map (kbd "<escape>") 'vterm--self-insert)
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.4))))

(use-package catppuccin-theme
  :ensure t)
(load-theme 'catppuccin :no-confirm)
(catppuccin-set-color 'base "#1E1E2E") ;; change base to #000000 for the currently active flavor
(catppuccin-set-color 'crust "#11111B" 'mocha) ;; change crust to #222222 for frappe
(catppuccin-reload)

(use-package tide
  :ensure t
  :after (company flycheck)
  :hook ((typescript-ts-mode . tide-setup)
         (tsx-ts-mode . tide-setup)
         (typescript-ts-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package vertico
  :ensure t
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package which-key
  :ensure t
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
    which-key-sort-order #'which-key-key-order-alpha
    which-key-allow-imprecise-window-fit nil
    which-key-sort-uppercase-first nil
    which-key-add-column-padding 1
    which-key-max-display-columns nil
    which-key-min-display-lines 6
    which-key-side-window-slot -10
    which-key-side-window-max-height 0.25
    which-key-idle-delay 0.8
    which-key-max-description-length 25
    which-key-allow-imprecise-window-fit nil
    which-key-separator " → " ))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
