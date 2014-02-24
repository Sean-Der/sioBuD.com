(in-package #:siobud)

(defvar *blog-posts-path* "/home/sean/public_html/siobud.com/lisp/blog/")
(defparameter *blog-posts*  `(("My Workflow"  "" "my-workflow" "2014-02-23")
                              ("Lisp And The Web " "" "lisp-web")))

(defun blog ()
  (let ((blog-post (alexandria:when-let (url (third (split-sequence:split-sequence #\/ (hunchentoot:request-uri hunchentoot:*request*))))
                     (or (find url *blog-posts* :test (lambda (url post) (equal  url (third post))))))))
    (with-templated-page (:title (if blog-post
                                   (format nil "(sioBuD.com (Blog (~A)))" (third blog-post))
                                   "(sioBuD.com (Blog))"))
      (if blog-post
        (cl-who:htm ((:div :class "article")
                     (handler-case (first (mapcar #'eval (cl-who::tree-to-commands (read-from-string (alexandria:read-file-into-string (concatenate 'string *blog-posts-path*
                                                                                       (third blog-post)
                                                                                       ".lisp"))) nil)))
                       (error ()
                              (cl-who:htm '((:h1 "Couldn't open blog post!")
                                            (:p "Well this shouldn't happen....")))))))
        (cl-who:htm (:div :class "article"
                        (:h1 "Most Recent Posts")
                        (:br)
                        (loop for blog-entry in  *blog-posts*
                              :when (fourth blog-entry)
                              :do (cl-who:htm (:h2 (cl-who:str (first blog-entry)))
                                              ((:p :class "blog-post-summary") (cl-who:str (second blog-entry)))
                                              ((:p :class "blog-post-summary") ((:a :href (concatenate 'string "blog/" (third blog-entry))) "Read More"))
                                              (:br)))))))))
