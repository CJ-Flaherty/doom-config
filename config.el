;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-solarized-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

    (map! :leader :n "w /" #'evil-window-vsplit)
    (map! :leader :n "w ?" #'split-window-vertically)
    (map! :leader :n "w x" #'evil-quit)
    (map! :leader :n "TAB" #'evil-switch-to-windows-last-buffer)
    (map! :leader :n "g d" #'haskell-hoogle-lookup-from-website)

    (map! :leader :n "g s" #'magit-status)
    (map! :leader :n "g v" #'magit-revert)
    (map! :leader :n "'" #'projectile-run-vterm)

    (map! :leader :n "1" #'winum-select-window-1)
    (map! :leader :n "2" #'winum-select-window-2)
    (map! :leader :n "3" #'winum-select-window-3)
    (map! :leader :n "4" #'winum-select-window-4)
    (map! :leader :n "?" #'+default/search-project-for-symbol-at-point)




""(setq explicit-shell-file-name "zsh")
(setq haskell-hoogle-url  "https://hoogle.internal.mercury.com/?hoogle=%s")

(after! lsp-haskell
        (setq lsp-haskell-server-path "static-ls")
  )
(defhydra doom-window-resize-hydra (:hint nil)
  "
_k_ increase height
_h_ decrease width
_l_ increase width
_j_ decrease height
"
("h" evil-window-decrease-width)
("j" evil-window-increase-height)
("k" evil-window-decrease-height)
("l" evil-window-increase-width)

("q" nil))

(map! :leader
    (:prefix "w"
      :desc "Hydra resize" :n "SPC" #'doom-window-resize-hydra/body))

;;(use-package! copilot
;;  :hook (prog-mode . copilot-mode)
;;  :bind (:map copilot-completion-map
;;              ("<tab>" . 'copilot-accept-completion)
;;              ("TAB" . 'copilot-accept-completion)
;;              ("C-TAB" . 'copilot-accept-completion-by-word)
;;              ("C-<tab>" . 'copilot-accept-completion-by-word)))



(defun jump-to-same-indent (direction)
  (interactive "P")
  (let ((start-indent (current-indentation)))
    (while
        (and (not (bobp))
             (zerop (forward-line direction))
             (or (= (current-indentation)
                    (- (line-end-position) (line-beginning-position)))
                 (> (current-indentation) start-indent)))))
  (back-to-indentation))

(with-eval-after-load 'evil-maps
  (
   define-key evil-motion-state-map  (kbd ")" ) 'jump-to-same-indent 1)
)

(with-eval-after-load 'evil-maps
  (
   define-key evil-motion-state-map  (kbd "(" ) (lambda () (interactive) (jump-to-same-indent -1)))
)
