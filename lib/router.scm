;This page is used as a router to include all our pages
(use awful regex directory-utils) 
(enable-sxml #t)


;Enable jQuery and then set the URL to the library
(enable-ajax #t)
(ajax-library "/js/jquery.min.js")

;Set our stylesheets
(page-css (list "/css/siobud.css"))

;Set our charset and doctype
(page-doctype "<!DOCTYPE html>")
(page-charset  "UTF-8")

;Define the root of our awful ((((hardy har har)))) website
(set! lib-root "/home/sean/public_html/siobud.com/lib/")

;load our template function, and then each page
(map (lambda (file) (load (string-append lib-root file)))
     `("template" "main-page" "music" "computing" "blog"))
