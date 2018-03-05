;; yasnippet-goodies-test.el --- 
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

(require 'yasnippet-goodies)
(require 'buttercup)

(defconst snippet-dir (f-join (f-parent load-file-name)
                              "snippets"))

(describe "yasnippet-goodies"
  (defun clean ()
    (setq completion-wrapper-default-completer 'first)

    (setq yas-snippet-dirs nil)
    (when (f-exists-p snippet-dir)
      (f-delete snippet-dir :force))
    (f-mkdir snippet-dir))

  (before-each
    (clean))

  (after-all
    (clean))

  (it "nyan"
    (setq yas-snippet-dirs (list snippet-dir))
    (let ((snippet-path (f-join snippet-dir
                                "emacs-lisp-mode"
                                "test.yasnippet")))
      (yasnippet-goodies-new-snippet "test" 'emacs-lisp-mode)
      (expect (f-exists-p snippet-path)
              :to-be t))
    )
  )

;; Local Variables:
;; eval: (put 'describe    'lisp-indent-function 'defun)
;; eval: (put 'it          'lisp-indent-function 'defun)
;; eval: (put 'before-each 'lisp-indent-function 'defun)
;; eval: (put 'after-each  'lisp-indent-function 'defun)
;; eval: (put 'before-all  'lisp-indent-function 'defun)
;; eval: (put 'after-all   'lisp-indent-function 'defun)
;; End:
