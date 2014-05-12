(in-package #:siobud)

(defvar *blog-posts-path* "/home/sean/public_html/siobud.com/lisp/blog/")
(defparameter *blog-posts*  `(("My Workflow"  "My Favorite Tools" "my-workflow" "2014-02-23")
                              ("Lisp And The Web" "Building A Simple WebApp With Common Lisp" "lisp-web" "2014-02-27")))

(defun render-blog-post ()
  (let ((comment-added-by (hunchentoot:parameter "comment-added-by"))
        (blog-post (alexandria:when-let (url (alexandria:when-let (dirty-url (third (split-sequence:split-sequence #\/ (hunchentoot:request-uri hunchentoot:*request*))))
                                               (first (split-sequence:split-sequence #\? dirty-url))))
                     (find url *blog-posts*
                           :test (lambda (url post) (equal  url (third post)))))))
      (with-templated-page (:title (if blog-post
                                     (format nil "(sioBuD.com (Blog (~A)))" (third blog-post))
                                     "(sioBuD.com (Blog))"))
        (if blog-post
          (cl-who:htm ((:div :class "article")
                       (:h1 (cl-who:str (first blog-post)))
                       (:h2 (cl-who:str (second blog-post)) ((:span :style "font-style: italic") " - Published " (cl-who:str (fourth blog-post))))
                       (handler-case (first (mapcar #'eval (cl-who::tree-to-commands (read-from-string (alexandria:read-file-into-string (concatenate 'string *blog-posts-path*
                                                                                         (third blog-post)
                                                                                         ".lisp"))) nil)))
                         (error ()
                                (cl-who:htm '((:h1 "Couldn't open blog post!")
                                              (:p "Well this shouldn't happen....")))))
                       ((:h1 :style "padding-top: 2em;") "Comments")

                       ((:h1 :style "padding-top: 2em;") "Post your own comment"))
                       ((:div :style "padding: 2em; padding-top: 0em;")
                        (if comment-added-by
                          (cl-who:str (concatenate 'string
                                                   "Thanks for the comment "
                                                   (cl-who:escape-string comment-added-by)
                                                   ". If it has not been posted in the next 24 hours feel free to email me!"))
                          (cl-who:htm ((:form  :action "/blog" :method "POST")
                                      ((:div :style "font-size: 18px; font-weight: 300") "Comments are not posted immediately, for the time being they will be emailed to
                                                 me along with your nick for review. In the future I may implement a text captcha,
                                                 but I am not keen on using a foreign service.")
                                      ((:div :style "padding-top: 1em") "Nick:")
                                      ((:input :type "text" :name "nick"))
                                      (:div "Comment:")
                                      ((:textarea :style "height: 100px; width: 400px;" :name "comment"))
                                      (:br)
                                      ((:input :type "hidden" :name "blog-post" :value (third blog-post)))
                                      ((:input :type "submit")))))))

          (cl-who:htm (:div :class "article"
                          (:h1 "Most Recent Posts")
                          (:br)
                          (loop for blog-entry in  *blog-posts*
                                :when (fourth blog-entry)
                                :do (cl-who:htm (:h2 (cl-who:str (first blog-entry)))
                                                ((:p :class "blog-post-summary") (cl-who:str (second blog-entry)) ((:span :style "font-style: italic") " - Published " (cl-who:str (fourth blog-entry))))
                                                ((:p :class "blog-post-summary") ((:a :href (concatenate 'string "blog/" (third blog-entry))) "Read More"))
                                                (:br)))))))))


(defun consume-blog-post ()
  (alexandria:if-let ((nick (hunchentoot:parameter "nick"))
                      (comment (hunchentoot:parameter "comment"))
                      (blog-post (hunchentoot:parameter "blog-post")))
    (sendmail:with-email (s "sean" :subject "New blogpost on SioBud.com")
      (format s "Post: ~A ~%Nick: ~A ~%IP Address: ~A ~%Comment: ~%~A" blog-post nick (hunchentoot:real-remote-addr) comment)
      (hunchentoot:redirect (concatenate 'string "http://siobud.com/blog/" blog-post "?comment-added-by=" nick)))
    "Invalid POST"))

(defun blog ()
  (if (eql :POST
           (hunchentoot:request-method*))
    (consume-blog-post)
    (render-blog-post)))
