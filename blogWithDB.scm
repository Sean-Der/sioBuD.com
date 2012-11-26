;Create a list of the five most recent blogposts
(define (blogPostOverview) 
	(map (lambda (n)
		`(div (@ (class "article"))
		 	(h2 ,(car n))
			(p ,(car (cdr n)))
			(p (a (@ (href "blog/",(car (cdr (cdr n))))) "Read More")))) 
		($db "SELECT title,summary,url from blogPosts ORDER BY id DESC LIMIT 5")))

(define (getBlogPost blogURL) 
	(if (= 1 (car (car ($db "SELECT COUNT(url) from blogPosts where url = $1" values: (list blogURL)))))
		`( ,(car (car ($db "SELECT COUNT(url) from blogPosts where url = $1" values: (list blogURL)))))
		`(h2 "Sorry! I was not able to find the blog post you are looking for")))

;Main page for all blog posts
(define-page "/blog"
  (lambda ()
		(set-page-title! "(sioBuD.com (Blog))")
			(template `(div ,(blogPostOverview)))))

;Page to fetch a specific blog post
(define-page (regexp "/blog/.*")
	(lambda (path)
		(define blogPost (string-substitute "/blog/" "" path))
		(set-page-title! "sioBuD.com")
		(template `(div (@ (class "article")) ,(getBlogPost blogPost)))))
