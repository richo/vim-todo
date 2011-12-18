This is (will be?) a syntax suite for todo files to make managing your todo
lists in git simpler

My intention is to make this a subset of markdown, markdown can be difficult to
manage in a purely cli environment because a lot of characters that are used in
amongst things that could be in a todo (code snippets for example) are
interpreted by the markdown parser, and escaping them inline is
counterproductive. Wrapping in backticks works, but is ugly in my opinion,
unless it's a big snippet in which case it hsould be highlighted correctly

For this reason, I will try to make this format as markdown compatible as
possible, essentially removing features that I feel break it's primary function
(look good in an editor- then if possible make it render all pretty like in a
browser)
