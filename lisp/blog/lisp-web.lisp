((:h1 "Why Lisp?")
 (:p "So Yahoo can buy my blog and pay me millions of course! Or maybe someone else already pulled that scam... Common Lisp for me has big three selling points. This is not an X vs Y comparison, but just some of the reasons why I look forward to writing Lisp.")

 (:h2 "Development Environment")
 (:p "The first thing that made me really love Lisp was how you write modern lisp. I have never used a development environment as intuitive as SWANK+slimv (or SLIME for Emacs users). Since my blog is a long running process I can connect to the process and run code at will, and if any exceptions occur a debugger opens up in vim and I can examine all the stack frames interactively.")

 (:h2 "DSLs/Macros")
 (:p "Macros for me have been a bumpy ride. At first they felt cryptic, and I was spending most of my time trying to get loop to do the right thing. After a while I started to really love how loop made blocks of code read more like prose and less like code! After I got the hang of that I wanted to write my own, and they all stunk. I was writing unsanitary macros left and right and they were needless most of the time. Right now I am wo ")

 (:h2 "Community")
 (:p "The Lisp community is really welcoming, and has a lot of smart people in it. I have asked lots of question, and had even more arguments in #lisp on Freenode. I am also really lucky to work on Lisp full time at " ((:a :href "http://http://webcheckout.net/") "Webcheckout") ". So I am learning from people who have years of commercial Lisp wisdom.")

 (:h1 "Lets build a webapp!")
 (:h2 "Install SBCL")
 (:pre (:code "
apt-get install sbcl //Debian and derivatives (Ubuntu)
pkg install sbcl //FreeBSD
pacman -S sbcl //ArchLinux"))
 (:h2 "Install QuickLisp")
 (:p "QuickLisp is a tool you can use to easily install Common Lisp Libraries, it integrates with ASDF and is easy to use")
 (:pre  ((:code :class "language-bash") "sean@siobud: curl http://beta.quicklisp.org/quicklisp.lisp -O
sean@siobud: sha256sum quicklisp.lisp
47cfdc0f4796b4c0ca05af16b666dd4b21c5b9e62b731390c895c2d19ed6d095  quicklisp.lisp
sean@siobud: sbcl --load quicklisp.lisp "))
(:pre ((:code :class "lanuage-lisp") "(quicklisp-quickstart:install)
(ql:add-to-init-file)"))

(:p "That is it, you now have a working QuickLisp Install! If you have any other questions " ((:a :href "http://www.quicklisp.org/beta/#installation") "here") " are the official docs Next we will create a new package to contain our Lisp Code")

(:h2 "Create a package, and add some libraries")
(:p "Next we are going to create the package for your webapp. We will use Hunchentoot for the HTTP server, cl-who so we can write our markup as s-expressions and slimv so we can work on debug+eval in vim. So open up SBCL, and run the following")
(:pre  ((:code :class "language-lisp") "(ql:quickload \"quickproject\")
(quickproject:make-project \"~/my-lisp-app/\" :depends-on '(hunchentoot cl-who swank))"))
(:p "Then create a symbol link for your newly created system into the QuickLisp local-projects folder. This makes loading the project with QuickLisp much easier")
(:pre (:code "ln -s ~/my-lisp-app ~/quicklisp/local-projects"))
(:h2 "Load SWANK, and connect to it via slimv")
(:p "Now lets load the new system, start swank and connect to it with vim.")
(:pre (:code "(ql:quickload 'my-lisp-app)
(in-package 'my-lisp-app)
(swank:create-server :dont-close t)"))
(:p "You now have a swank server that you connect to. Open my-lisp-app.lisp in ~/my-lisp-app, and with a <leader>-c you are connected! Your screen should look like the following")
((:img :alt "slimv" :class "centered-image" :src "/img/blog/lisp-web/slimv.png"))
(:p "On the left hand side we have the Lisp file, and on the right our REPL. Now that we are connected, lets eval some code into the running image, and get a little demo of the common lisp workflow. Add the following function to my-lisp-app.lisp")
(:pre (:code " (defun web-fun ()
  (cl-who:with-html-output (*standard-output*) (:h1 \"Test\")))"))
(:p "Then with slimv loaded put your cursor inside the defun, with a C-d you can load the function into your currently running instance. Now we just need a HTTP request to call this function. Execute the following in your REPL, and then load localhost:4000 in your web browser")
(:pre (:code "(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4000))
(push (hunchentoot:create-prefix-dispatcher \"/\" 'web-fun) hunchentoot:*dispatch-table*)"))
(:h1 "Wrapping Up")
(:p "Now wasn't that fun! Update the s-expression in #'webfun and display even more complicated markup. If this piqued your interest, and you want to learn more I recommend" ((:a :href "http://www.gigamonkeys.com/book/") "Practical Common Lisp") " it is a book, and gives you plenty of real world examples."))
