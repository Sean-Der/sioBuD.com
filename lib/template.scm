(define (template content)
  `( 
      (nav 
        (ul
          (li (a (@(href "/")) "Home"))
          (li (a (@(href "javascript:void(0);")) "Interests")
            (ul
              (li (a (@(href "/interests/music")) "Music"))
              (li (a (@(href "/interests/computing")) "Computing"))))
          (li (a (@(href "/blog")) "Blog") )
          (li (a (@(href "javascript:void(0);")) "Résumé")
            (ul
              (li (a (@(href "/resume/")) "HTML"))
              (li (a (@(href "/resume/resume.pdf")) "PDF"))))))
      (div (@ (id "frame")) 
        (div (@ (id "about_me")) 
          (span (@ (id "name")) "Sean DuBois") 
          (p "Programmer")
          (p "Audiophile")
          (img (@ (src "/img/gravatar.jpg") (id "gravatar")))
          (br)
          (p (a (@(href "http://www.github.com/sean-der"))"GitHub")) 
          (p (a (@(href "http://www.discogs.com/collection?user=Sean-Der"))"Discogs")) 
          (p (a (@(href "mailto:sean@siobud.com"))"Email")) ) 
      (div (@(id "content")), content))))
