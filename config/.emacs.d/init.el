;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

; クソのようなツールバーを消す(GUI用)

(tool-bar-mode -1)
(menu-bar-mode -1)

; デフォルトの文字コードはUTF-8に決まってるだろ
(prefer-coding-system 'utf-8)

; screen とバッティングしてうまく行かないところは
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'transpose-line-up)
(global-set-key [(meta down)] 'transpose-line-down)

; フォントサイズをいい感じにする
; (set-default-font "IPAGothic:pixelsize=14:spacing=0")

; Ctrl＋h を backspace にする
(global-set-key "\C-h" 'delete-backward-char)

; Indent にタブを使わないようにする
(setq-default indent-tabs-mode nil)

; 行番号を表示する
(require 'linum)
(global-linum-mode)

(setq c-basic-offset 4)

;; My org-mode 設定

; (require 'org-install)
;; org-default-notes-fileのディレクトリ
(setq org-directory "~/org/")
;;(setq org-directory "~/src/github.com/mitoma/org-memo")
;; org-default-notes-fileのファイル名
(setq org-default-notes-file "notes.org")

(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

;; 見出しの余分な*を消す
; 不要かな…
; (setq org-hide-leading-stars t)
;; 画面端で改行する
(setq org-startup-truncated nil)
;; 見出しを畳まない
(setq org-startup-folded nil)
;; returnでリンクを飛ぶ
(setq org-return-follows-link t)
;; agendaを使う
(setq org-agenda-files (list org-directory))
;; 
(setq org-capture-templates
  '(
    ("t" "Todo" entry (file+headline nil "Tasks")                 "** TODO %?\n  %i\n  %a")
                                        ;    ("m" "Memo" entry (file+headline nil "Memos")                 "** %?\n   %T")
                                        ;    ("M" "Memo(with file link)" entry (file+headline nil "Memos") "** %?\n   %a\n   %T")
    ("m" "Memo" entry (file+headline "~/org/memos.org" "Memos")                 "** %?")
    ("j" "Journal" entry (file+datetree "~/org/journal.org")      "* %?\nEntered on %U\n  %i\n  %a")))

;; org-capture-memo
(defun org-capture-memo (n)
  (interactive "p")
  (case n
    (4 (org-capture nil "M"))
    (t (org-capture nil "m"))))

;; open-junk-file 
; (require 'open-junk-file)
; (setq open-junk-file-format "~/src/github.com/mitoma/org-memo/junk/%Y-%m-%d.org")
; (global-set-key "\C-xj" 'open-junk-file)


;; emacs mozc
; (require 'mozc)
; (set-language-environment "Japanese")
; (setq default-input-method "japanese-mozc")

;; ---------------------------------------------------
;; sdic
;; ---------------------------------------------------
; (autoload 'sdic-describe-word "sdic" "search word" t nil)
; (global-set-key "\C-ce" 'sdic-describe-word)
; (autoload 'sdic-describe-word-at-point "sdic" "カーソル位置の英単語の意味を調べる" t nil)
; (global-set-key "\C-ce" 'sdic-describe-word-at-point)
; 
; (eval-after-load "sdic"
;   '(progn
;      (setq sdicf-array-command "/usr/bin/sary") ; コマンドパス
;      (setq sdic-eiwa-dictionary-list
;            '((sdicf-client "/usr/share/dict/eijiro-utf8.sdic" (strategy array)))
;            sdic-waei-dictionary-list
;            '((sdicf-client "/usr/share/dict/waeijiro-utf8.sdic" (strategy array))))
; 
;      ;; saryを直接使用できるように sdicf.el 内に定義されているarrayコマンド用関数を強制的に置換
;      (fset 'sdicf-array-init 'sdicf-common-init)
;      (fset 'sdicf-array-quit 'sdicf-common-quit)
;      (fset 'sdicf-array-search
;            (lambda (sdic pattern &optional case regexp)
;              (sdicf-array-init sdic)
;              (if regexp
;                  (signal 'sdicf-invalid-method '(regexp))
;                (save-excursion
;                  (set-buffer (sdicf-get-buffer sdic))
;                  (delete-region (point-min) (point-max))
;                  (apply 'sdicf-call-process
;                         sdicf-array-command
;                         (sdicf-get-coding-system sdic)
;                         nil t nil
;                         (if case
;                             (list "-i" pattern (sdicf-get-filename sdic))
;                           (list pattern (sdicf-get-filename sdic))))
;                  (goto-char (point-min))
;                  (let (entries)
;                    (while (not (eobp)) (sdicf-search-internal))
;                    (nreverse entries))))))
; 
;      (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
;        (recenter 0))
;      (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
;        (recenter 0))))
; (setq sdic-default-coding-system 'utf-8-unix)

;;; diff region
(defun diff-region ()
  "Select a region to compare"
  (interactive)
  (when (use-region-p)  ; there is a region
        (let (buf)
          (setq buf (get-buffer-create "*Diff-regionA*"))
          (save-current-buffer
            (set-buffer buf)
            (erase-buffer))
          (append-to-buffer buf (region-beginning) (region-end)))
        )
  (message "Now select other region to compare and run `diff-region-now`")
  )

(defun diff-region-now ()
  "Compare current region with region already selected by `diff-region`"
  (interactive)
  (when (use-region-p)
        (let (bufa bufb)
          (setq bufa (get-buffer-create "*Diff-regionA*"))
          (setq bufb (get-buffer-create "*Diff-regionB*"))
          (save-current-buffer
            (set-buffer bufb)
            (erase-buffer))
          (append-to-buffer bufb (region-beginning) (region-end))
          (ediff-buffers bufa bufb))
        )
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (open-junk-file ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
