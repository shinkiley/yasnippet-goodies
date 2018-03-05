;;; yasnippet-goodies.el --- 
;;
;; Author:  <shinki@yui-pc>
;; Version: 0.1
;; URL: 
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; .
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(require 'f)
(require 'yasnippet)

(require 'emacs-ef)
(require 'completion-wrapper)

(ef-prefixied yg yasnippet-goodies
  (defun-yg new-snippet (snippet-name &optional mode)
    "Create new snippet.
If MODE provided add snippet to mode's dir.
Otherwise, add snippet to dir of `major-mode'."
    (interactive)
    (let ((snippets-dir (completion-wrapper-complete yas-snippet-dirs)))
      ($@- check-dir-exists snippets-dir)

      (let* ((target-mode (symbol-name (or mode
                                           major-mode)))
             (mode-dir (f-join snippets-dir
                               target-mode))
             (snippet-filename ($@- format-snippet-filename
                                    snippet-name))
             (snippet-path (f-join mode-dir
                                   snippet-filename)))
        ($@- ensure-dir-is-created mode-dir)
        (find-file snippet-path)
        (save-buffer))))

  (defun-yg- format-snippet-filename (snippet-name)
    (format "%s.yasnippet" snippet-name))

  (defun-yg- ensure-dir-is-created (dirpath)
    "If DIRPATH is not a directory create it."
    (unless (f-directory-p dirpath)
      (f-mkdir dirpath)))

  (defun-yg- check-dir-exists (dirpath)
    "Raises an error of directory with DIRPATH doesn't exist."
    (unless (f-directory-p dirpath)
      (error "Directory %s doesn't exits" dirpath)))
  )

(provide 'yasnippet-goodies)
;;; yasnippet-goodies.el ends here
