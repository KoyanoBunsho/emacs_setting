;;; Package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
;;; 対応する括弧を光らせる。
(show-paren-mode 1)
;;; 選択部分をハイライト
(transient-mark-mode t)
;;; バックアップファイルを作らない
(setq backup-inhibited t)
;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)
                                        ; comment color
(set-face-foreground 'font-lock-comment-face "#cc0000")
                                        ; key bind
(global-set-key "\C-h" 'backward-delete-char)
;; show unuseful whitespace
(setq-default show-trailing-whitespace t)
;; limit 79
(add-hook 'python-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("^[^\n]\\{79\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("^[^\n]\\{79\\}\\(.*\\)$" 1 font-lock-warning-face t)))))
;; prevent indent tabs
(setq-default indent-tabs-mode nil)
(electric-indent-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'company)
(global-company-mode) ; 全バッファで有効にする
(setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
(setq company-idle-delay 0) ; デフォルトは0.5
(setq company-minimum-prefix-length 3) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
(define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
(define-key company-active-map (kbd "C-f") 'company-complete-selection) ;; C-fで候補を設定
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
;; yasnippetとの連携
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))
(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(electric-pair-mode 1)
;; display line numbers
(if (version<= "26.0.50" emacs-version)
    (progn
      (global-display-line-numbers-mode)
      ;; テーマはdeeper-blueを使用している。これに合わせた色を選んだつもり
      (set-face-attribute 'line-number nil
                          :foreground "DarkOliveGreen"
                          :background "#131521")
      (set-face-attribute 'line-number-current-line nil
                          :foreground "gold")))
(global-linum-mode t)

