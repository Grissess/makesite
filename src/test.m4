MS_HEAD(`Test Page')

<h1>Test page</h1>

<p>Hello! Here are some test links:</p>
<ul>
	<li><a href="sibling.html">Sibling page</a></li>
	<li><a href="child/index.html">Child page</a></li>
</ul>

<p>The following pages are defined:</p>
<ul>
MS_FOREACH(`name', `<li><code>name</code></li>MS_NL', MS_BUILDS)
</ul>

<p>And here are the following again, but only in this directory:</p>
<ul>
MS_FOREACH(`name', `m4_ifelse(m4_index(m4_defn(`name'), `/'), `-1', `<li><code>name</code></li>', `')', MS_BUILDS)
</ul>
