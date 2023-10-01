<?xml version="1.0" encoding="ISO-8859-1"?>

<!-- This is an example of a translation to be used with bib2html
     http://www.cs.cmu.edu/~pfr/misc_software/index.html#bib2html
     This is what I use for my site
     http://www.cs.cmu.edu/~pfr/publications/
-->

<xsl:stylesheet 
  version="1.0"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:b2h="http://www.cs.cmu.edu/~pfr/misc_software/index.html#bib2html"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="date b2h xsl">
<!--   xmlns="http://www.w3.org/TR/html4/loose.dtd"  -->

<xsl:import href="external/date.format-date.template.xsl" />

<xsl:output 
  method="html" 
  version="4.0"
  doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
  doctype-system="http://www.w3.org/TR/html4/loose.dtd"
  encoding="iso-8859-1" 
  indent="yes"/>

<xsl:strip-space elements="b2h:size b2h:file_format b2h:exists b2h:datetime" />

<xsl:template match="b2h:main_index_links">
  <p><big>&#8226;
  <xsl:for-each select="b2h:index_link">
   <a>
    <xsl:attribute name="href">
     <xsl:value-of select="b2h:url" />
    </xsl:attribute>
    <xsl:value-of select="b2h:name"/>
   </a> &#8226;
  </xsl:for-each>
  </big></p>
</xsl:template>

<!-- A template to format the number of bytes into something a little more human
     readable -->
<xsl:template name="size" match="b2h:size">
 <xsl:choose>
  <xsl:when test=".&gt;1024*1024*1024">
   <xsl:value-of select="format-number(. div (1024*1024*1024), '#.0')" />GB
  </xsl:when>
  <xsl:when test=".&gt;1024.0*1024.0">
   <xsl:value-of select="format-number(. div (1024*1024), '#.0')" />MB
  </xsl:when>
  <xsl:when test=".&gt;1024.0">
   <xsl:value-of select="format-number(. div (1024), '#.0')" />kB
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="format-number(. , '#')" />kB
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- A long format of download links, to be used with call-template -->
<xsl:template name="dl_link_long">
 <xsl:param name="dl" />
 <xsl:choose>
  <xsl:when test="count($dl/b2h:download_entry[b2h:exists=1 or b2h:exists='true']) != 0">
   <xsl:for-each select="$dl/b2h:download_entry">
    <xsl:if test="b2h:exists=1 or b2h:exists='true'">
     <a>
      <xsl:attribute name="href">
       <xsl:value-of select="b2h:url" />
      </xsl:attribute>
      <xsl:choose>
       <xsl:when test="b2h:file_format='pdf'">[PDF]</xsl:when>
       <xsl:when test="b2h:file_format='extended.pdf'">[Extended Version, PDF]</xsl:when>
       <xsl:when test="b2h:file_format='slides.pdf'">[Slides, PDF]</xsl:when>
       <xsl:when test="b2h:file_format='slides.ppt'">[Slides, PPT]</xsl:when>
       <xsl:when test="b2h:file_format='slides.pptx'">[Slides, PPTX]</xsl:when>
       <xsl:when test="b2h:file_format='poster.pdf'">[Presented Poster, PDF]</xsl:when>

       <xsl:when test="b2h:file_format='ps.gz'">[gzipped postscript]</xsl:when>
       <xsl:when test="b2h:file_format='ps'">[postscript]</xsl:when>
       <xsl:when test="b2h:file_format='html'">[HTML]</xsl:when>
       <xsl:otherwise>[unknown format]
        <xsl:message>Warning: Unknown file format: <xsl:value-of select="b2h:file_format" /></xsl:message>
       </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="b2h:size" />
     </a> 
     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
    </xsl:if>
   </xsl:for-each>
  </xsl:when>
  <xsl:otherwise>
  (unavailable)
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- A short format of download links, to be used with call-template -->
<xsl:template name="dl_link_short">
 <xsl:param name="dl" />
 <xsl:choose>
  <xsl:when test="count($dl/b2h:download_entry[b2h:exists=1 or b2h:exists='true']) != 0">
   <xsl:for-each select="$dl/b2h:download_entry">
    <xsl:if test="b2h:exists=1 or b2h:exists='true'">
     <a>
      <xsl:attribute name="href">
       <xsl:value-of select="b2h:url" />
      </xsl:attribute>
      <xsl:choose>
       <xsl:when test="b2h:file_format='pdf'">[pdf]</xsl:when>
       <xsl:when test="b2h:file_format='extended.pdf'">[extended, pdf]</xsl:when>
       <xsl:when test="b2h:file_format='slides.pdf'">[slides, pdf]</xsl:when>
       <xsl:when test="b2h:file_format='slides.ppt'">[slides, ppt]</xsl:when>
       <xsl:when test="b2h:file_format='slides.pptx'">[slides, pptx]</xsl:when>
       <xsl:when test="b2h:file_format='poster.pdf'">[poster, pdf]</xsl:when>


       <xsl:when test="b2h:file_format='ps.gz'">[ps.gz]</xsl:when>
       <xsl:when test="b2h:file_format='ps'">[ps]</xsl:when>
       <xsl:when test="b2h:file_format='html'">[HTML]</xsl:when>
       <xsl:otherwise>[unknown format]
        <xsl:message>Warning: Unknown file format: <xsl:value-of select="b2h:file_format" /></xsl:message>
       </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="count(b2h:size) != 0">
       (<xsl:apply-templates select="b2h:size" />)
      </xsl:if>
     </a> 
     <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
    </xsl:if>
   </xsl:for-each>
  </xsl:when>
  <xsl:otherwise>
  (unavailable)
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- Template for the crediting of the generated info -->
<xsl:template match="b2h:generation_info">
 Generated by
 <a>
  <xsl:attribute name="href">
   <xsl:value-of select="b2h:program_url" />
  </xsl:attribute>
  <xsl:value-of select="b2h:program" />
 </a>
 (written by <a>
  <xsl:attribute name="href">
   <xsl:value-of select="b2h:author_url" />
  </xsl:attribute>
  <xsl:value-of select="b2h:author" />
  </a>
  ) on
  <xsl:call-template name="date:format-date">
   <xsl:with-param name="date-time" select="b2h:datetime" />
   <!-- I used to have a zzz at the end here, but I no longer put time zone information in the
        xml file (because that requires the Time::Zone package in perl) -->
   <xsl:with-param name="pattern" select="'EEE MMM dd, yyyy HH:mm:ss'" />
  </xsl:call-template>
</xsl:template>

<xsl:template name="paper_info_short">
 <xsl:param name="paper_info" />
  <xsl:value-of select="$paper_info/b2h:citation" disable-output-escaping="yes"/>
  <br /> 
  <xsl:if test="$paper_info/b2h:detail_url">
   <a>
    <xsl:attribute name="href"><xsl:value-of select="$paper_info/b2h:detail_url" /></xsl:attribute>
    Details
   </a>
   <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
  </xsl:if>
  <xsl:if test="$paper_info/b2h:bibtex_url">
   <a>
    <xsl:attribute name="href"><xsl:value-of select="$paper_info/b2h:bibtex_url" /></xsl:attribute>
    BibTeX
   </a>
   <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
  </xsl:if>
  Download: 
  <xsl:call-template name="dl_link_short">
   <xsl:with-param name="dl" select="$paper_info/b2h:download_links" />
  </xsl:call-template>
</xsl:template>

<!-- Note that this template does NOT print a header for this group. You should
     do that before applying this template -->
<xsl:template match="b2h:group_papers">
 <ul>
 <xsl:for-each select="b2h:paper_info">
  <li>
   <xsl:call-template name="paper_info_short">
    <xsl:with-param name="paper_info" select="." />
   </xsl:call-template>
  </li>
 </xsl:for-each>
 </ul>
</xsl:template>

<!--  The main template to match for a list of paper page -->
<!-- Note that this is a named template you have to call with call-template -->
<xsl:template name="list_papers_with_sep">
 <xsl:param name="list" />

 <html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>Jeff A. Bilmes Homepage</title>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
   <meta name="Keywords" content="Jeff Bilmes, Bilmes" />
   <meta name="Description" content="Jeff Bilmes's Home Page." />
   <link rel="stylesheet" href="../bilmes_style.css" type="text/css" />
</head>
<body>
<div class="container">
<!-- put the above at the top of every page -->

 
<div class="navigation">
<!-- Site navigation menu -->
<ul class="navbar">
  <li><a href="index.html">Home</a>     
      </li>  
  <li><a href="about.html">About</a>     
      </li>  
  <li><a href="prospective.html">Prospective Students</a>
  </li>
  <li><a href="teaching.html">Teaching</a>
  </li>
  <li><a href="research.html">Research</a>
  </li>
  <li><a href="people.html">People</a>
  </li>
  <li><a href="sort_date.html">Publications</a>
  </li>
  <li><a href="software.html">Software 
                              &amp;&#xA0;Data</a>
  </li>
  <li><a href="talks.html">Talks</a>
  </li>
</ul>
</div> <!-- end navigation -->



 <div class="content">
    <div id="toptitle">
    <h1><a href="index.html">Jeff A. Bilmes</a>'s Publications</h1>
 </div>

  <xsl:apply-templates select="$list/b2h:main_index_links" />

  <h2> <xsl:value-of select="$list/b2h:list_title"/> </h2>

  <!-- First, we'll format the index links -->
  <p>&#8226;
  <xsl:for-each select="$list/b2h:list_group_papers/b2h:group_papers">
   <a>
    <xsl:attribute name="href">#<xsl:value-of select="b2h:group_title" /></xsl:attribute>
    <xsl:value-of select="b2h:group_title" disable-output-escaping="yes"/>
   </a>
   &#8226;
  </xsl:for-each>
  </p>
  
  <hr width="100%" size="2"/>

  <xsl:for-each select="$list/b2h:list_group_papers/b2h:group_papers">
   <h3>
    <a>
     <xsl:attribute name="name"><xsl:value-of select="b2h:group_title" /></xsl:attribute>    
    </a>
    <xsl:value-of select="b2h:group_title" disable-output-escaping="yes"/>
   </h3>
   <xsl:apply-templates select="." />
  </xsl:for-each>  

  <hr width="100%" size="2"/>
  <p><small>
  <xsl:apply-templates select="$list/b2h:generation_info" />
  </small> </p>
 </div> <!-- end content -->

 
<!-- put the below at the end of every page -->
<div class="footer">
<a class="right_pad" href="index.html">
Go home</a>
<a class="right_pad" href="http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=" onclick="window.open('http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=300'); return false;" title="Reveal this e-mail address">Email me</a> Last updated Sun Oct 01 02:42 PDT 2023
 

</div>
</div> <!-- end container -->
</body>
</html>


</xsl:template>

<!--  The main template to match for a list of paper page with the group boundaries ignored -->
<!-- Note that this is a named template you have to call with call-template -->
<xsl:template name="list_papers_no_sep">
 <xsl:param name="list" />

 <html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>Jeff A. Bilmes Homepage</title>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
   <meta name="Keywords" content="Jeff Bilmes, Bilmes" />
   <meta name="Description" content="Jeff Bilmes's Home Page." />
   <link rel="stylesheet" href="../bilmes_style.css" type="text/css" />
</head>
<body>
<div class="container">
<!-- put the above at the top of every page -->

 
<div class="navigation">
<!-- Site navigation menu -->
<ul class="navbar">
  <li><a href="index.html">Home</a>     
      </li>  
  <li><a href="about.html">About</a>     
      </li>  
  <li><a href="prospective.html">Prospective Students</a>
  </li>
  <li><a href="teaching.html">Teaching</a>
  </li>
  <li><a href="research.html">Research</a>
  </li>
  <li><a href="people.html">People</a>
  </li>
  <li><a href="sort_date.html">Publications</a>
  </li>
  <li><a href="software.html">Software 
                              &amp;&#xA0;Data</a>
  </li>
  <li><a href="talks.html">Talks</a>
  </li>
</ul>
</div> <!-- end navigation -->




 <div class="content">
    <div id="toptitle">
    <h1><a href="index.html">Jeff A. Bilmes</a>'s Publications</h1>
 </div>


  <xsl:apply-templates select="$list/b2h:main_index_links" />

  <h2> <xsl:value-of select="$list/b2h:list_title"/> </h2>

  <hr width="100%" size="2"/>

  <ul>
   <xsl:for-each select="$list/b2h:list_group_papers/b2h:group_papers/b2h:paper_info">
    <li>
     <xsl:call-template name="paper_info_short">
      <xsl:with-param name="paper_info" select="." />
     </xsl:call-template>
    </li>
   </xsl:for-each>  
  </ul>

  <hr width="100%" size="2"/>
  <p><small>
  <xsl:apply-templates select="$list/b2h:generation_info" />
  </small> </p>

 </div> <!-- end content -->

 
<!-- put the below at the end of every page -->
<div class="footer">
<a class="right_pad" href="index.html">
Go home</a>
<a class="right_pad" href="http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=" onclick="window.open('http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=300'); return false;" title="Reveal this e-mail address">Email me</a> Last updated Sun Oct 01 02:42 PDT 2023
 

</div>
</div> <!-- end container -->
</body>
</html>


</xsl:template>

<!--  The main template to match for a paper detail page -->
<xsl:template match="b2h:paper_detail">

 <html lang="en-US" xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>Jeff A. Bilmes Homepage</title>
   <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
   <meta name="Keywords" content="Jeff Bilmes, Bilmes" />
   <meta name="Description" content="Jeff Bilmes's Home Page." />
   <link rel="stylesheet" href="../bilmes_style.css" type="text/css" />
</head>
<body>
<div class="container">
<!-- put the above at the top of every page -->

 
<div class="navigation">
<!-- Site navigation menu -->
<ul class="navbar">
  <li><a href="index.html">Home</a>     
      </li>  
  <li><a href="about.html">About</a>     
      </li>  
  <li><a href="prospective.html">Prospective Students</a>
  </li>
  <li><a href="teaching.html">Teaching</a>
  </li>
  <li><a href="research.html">Research</a>
  </li>
  <li><a href="people.html">People</a>
  </li>
  <li><a href="sort_date.html">Publications</a>
  </li>
  <li><a href="software.html">Software 
                              &amp;&#xA0;Data</a>
  </li>
  <li><a href="talks.html">Talks</a>
  </li>
</ul>
</div> <!-- end navigation -->



 <div class="content">
    <div id="toptitle">
    <h1><a href="index.html">Jeff A. Bilmes</a>'s Publications</h1>
 </div>


  <xsl:apply-templates select="b2h:main_index_links" />

  <h2> <xsl:value-of select="b2h:paper_info/b2h:title" disable-output-escaping="yes"/> </h2>

   <p class="citation">
   <xsl:value-of select="b2h:paper_info/b2h:citation" disable-output-escaping="yes" /> 
   </p>	

   <h3>Download</h3>
   <p>
    <xsl:call-template name="dl_link_long">
     <xsl:with-param name="dl" select="b2h:paper_info/b2h:download_links" />
    </xsl:call-template>
   </p>

   <h3>Abstract</h3>
   <p class="abstract">
    <xsl:choose>
     <xsl:when test="b2h:paper_info/b2h:abstract">
      <xsl:value-of select="b2h:paper_info/b2h:abstract" disable-output-escaping="yes" /> 
     </xsl:when>
     <xsl:otherwise>
      (unavailable)
     </xsl:otherwise>
    </xsl:choose>
   </p>

   <xsl:if test="b2h:paper_info/b2h:extra_info">
    <h3>Additional Information</h3>
    <p><xsl:value-of select="b2h:paper_info/b2h:extra_info" disable-output-escaping="yes" /></p>
   </xsl:if>

   <xsl:choose>
    <xsl:when test="b2h:paper_info/b2h:bibtex_url">
     <a>
      <xsl:attribute name="href"><xsl:value-of select="b2h:paper_info/b2h:bibtex_url" /></xsl:attribute>
      <h3>BibTeX</h3>
     </a>
    </xsl:when>
    <xsl:otherwise>
     <h3>BibTeX Entry</h3>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:choose>
    <xsl:when test="b2h:paper_info/b2h:bibtex_entry">
     <pre>
      <xsl:value-of select="b2h:paper_info/b2h:bibtex_entry"/> 
     </pre>
    </xsl:when>
    <xsl:otherwise>
     (unavailable)
    </xsl:otherwise>
   </xsl:choose>


   <h3>Share</h3>
   <p class="share">
<!-- AddThis Button BEGIN -->
<div class="addthis_toolbox addthis_default_style addthis_32x32_style">
<a class="addthis_button_preferred_1"></a>
<a class="addthis_button_preferred_2"></a>
<a class="addthis_button_preferred_3"></a>
<a class="addthis_button_preferred_4"></a>
<a class="addthis_button_compact"></a>
</div>
<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4e39e6cc4ff7d9d9"></script>
<!-- AddThis Button END -->
   </p>


   <hr width="100%" size="2"/>
   <p><small>
   <xsl:apply-templates select="b2h:generation_info" />
   </small> </p>

 </div> <!-- end content -->

 
<!-- put the below at the end of every page -->
<div class="footer">
<a class="right_pad" href="index.html">
Go home</a>
<a class="right_pad" href="http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=" onclick="window.open('http://mailhide.recaptcha.net/d?k=01l3ho3qEvdj--sJ6OJ8LS1A==&amp;c=7CXXfzP4KrBHZwLeD1xbEluzWyfYR5lzjGozsG53sBw=', '', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=500,height=300'); return false;" title="Reveal this e-mail address">Email me</a> Last updated Sun Oct 01 02:42 PDT 2023
 

</div>
</div> <!-- end container -->
</body>
</html>


</xsl:template>

<!--  The main templates for the list of papers pages -->

<xsl:template match="b2h:list_papers_by_default">
 <xsl:call-template name="list_papers_no_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_date">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_author">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_author_class">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_pubtype">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_rescat">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

<xsl:template match="b2h:list_papers_by_funding">
 <xsl:call-template name="list_papers_with_sep">
  <xsl:with-param name="list" select="." />
 </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
