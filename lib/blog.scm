;Create a list of the most recent blogposts
(define (blog-post-overview) 
  (load (string-append lib-root "blog-posts"))
  (map (lambda (n)
    `((h2 ,(car n))      
      (p (@ (class "blog-post-summary")) ,(car (cdr n)))
      (p (@ (class "blog-post-summary")) (a (@ (href "blog/",(car (cdr (reverse n))))) "Read More"))
      (br))) 
    (filter (lambda (post) 
              (car (reverse post))) 
            posts)))

(define (load-blog-post blog-url)
  (load (conc lib-root "blog/" blog-url))
  (load (string-append lib-root "blog-posts"))
  (let ((post (find (lambda (post)  
                      (string=? blog-url (car (cdr (cdr post))))) posts)))
    `((h1 (@ (id "blog-post-title1")) ,(car post))  
      (h2 (@ (id "blog-post-title2")) ,(car (cdr post)))
      ,article)))

(define (get-blog-post blog-url) 
    (if (file-exists/directory? (conc lib-root "blog/" blog-url ".scm"))
    (load-blog-post blog-url)
    `(h2 "Sorry! I was not able to find the blog post you are looking for")))

;Main page for all blog posts
(define-page "/blog"
  (lambda ()
    (set-page-title! "(sioBuD.com (Blog))")
      (template 
        `(div (@ (class "article")) 
          (h1 "Most Recent Posts")
          (br)
          ,(blog-post-overview)))))

;Page to fetch a specific blog post
(define-page (regexp "/blog/.*")
  (lambda (path)
    (define blog-post (string-substitute "/blog/" "" path))
        (set-page-title! (string-append "(sioBuD.com (Blog (" blog-post ")))"))
    (template `(div (@ (class "article")) ,(get-blog-post blog-post)
                    )))
  headers: (include-javascript "/js/centered-image.js"))
