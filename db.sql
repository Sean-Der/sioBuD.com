DROP TABLE blogPosts;

create table blogPosts(
	id serial PRIMARY KEY,
	title text NOT NULL,
	URL text NOT NULL,
	summary text NOT NULL,
	article text NOT NULL
);

insert into blogPosts(title, URL, summary, article) VALUES('The Web - Lowering the bar hurt more than helped', 'web-lowered-bar', 'Lowering the bar for web programming hurt us, more than that it helped. And how we can fix it', '(p PHP is Kool)');
insert into blogPosts(title, URL, summary, article) VALUES('My Workflow - beauty in simplicity', 'my-workflow', 'How a mastery of simple tools can go a long way', '(p Vim sux)');
