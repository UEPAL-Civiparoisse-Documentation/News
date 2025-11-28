<?php
$doc=new DOMDocument();
$doc->load("rss_master.xml");
$doc->formatOutput=true;
$doc->resolveExternals=true;
$doc->xinclude(LIBXML_NSCLEAN);
$doc->save('site/rss2.xml');
