(in-package #:siobud)

(defvar *urls* (list "/" 'main "/interests/computing" 'computing "/blog" 'blog))

(defun start-server ()
  (swank:create-server :style :spawn :dont-close t)
  (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242 :address "127.0.0.1"))
  (loop for (url fun) on *urls* by #'cddr
        :do (push (hunchentoot:create-prefix-dispatcher url fun) hunchentoot:*dispatch-table*)))

(defun main ()
  (with-templated-page (:title "(sioBuD.com)")
    ((:div :id "welcome")
            ((:h1 :style "font-size: 50px") "Hi!")
            ((:h1 :style "font-size: 30px") "My name is " ((:span :style "font-weight: 700") "Sean DuBois") " and this is my webpage")
            (:br)
            ((:h1 :style "font-size: 30px") "My day job involves " ((:a :class "fancyAnchor" :href "/interests/computing" :style "font-weight: 700") "Programming") "! Make sure to check out my  "((:a :class "fancyAnchor" :href "/blog" :style "font-weight: 700") "Blog") " and  "  ((:a :class "fancyAnchor" :href "http://github.com/sean-der" :style "font-weight: 700") "GitHub") " to see what I am working on.")
            ((:h1 :style "font-size: 30px; padding-top: 4em") "Important Note!")
            (:p "I take your privacy very seriously. When you access this website I don't fetch anything from an external " ((:a :class "fancyAnchor" :href "https://en.wikipedia.org/wiki/Content_delivery_network") "CDN") )
            (:p "I do not employ any sort of "((:a :class "fancyAnchor" :href "https://en.wikipedia.org/wiki/Google_Analytics") "Analytics") " I am not interested in tracking you.")
            (:p "There is only very simple logging on this server, it is used by  " (:a :class "fancyAnchor" :href "http://www.fail2ban.org/wiki/index.php/Main_Page" "Fail2Ban")" to prevent malicous attacks.")
            (:p "You should demand these things from every web server you visit. "((:a :class "fancyAnchor" :href "http://www.mozilla.org/en-US/collusion/") "Mozilla's Collusion")))))
