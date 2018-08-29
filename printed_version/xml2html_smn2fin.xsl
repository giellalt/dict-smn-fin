<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it:main THIS_FILE inDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs xhtml local">
  
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:output method="text" name="txt"
              encoding="UTF-8"/>
  
  <xsl:output method="html" name="html"
              encoding="UTF-8"
              version="4.0"
              indent="yes"/>
  
  <xsl:param name="inDir" select="'0_input_smnfin'"/>
  <xsl:param name="outDir" select="'1_html_smn2fin'"/>
  <xsl:variable name="of" select="'html'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="false()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>
  <xsl:variable name="sr" select="'\*'"/>
  <xsl:variable name="rarrow" select="'▸'"/>
  <xsl:variable name="tb" select="' 	 '"/>
  
  <xsl:variable name="abc">  
    <l>a</l>
    <l>â</l>
    <l>b</l>
    <l>c</l>
    <l>č</l>
    <l>d</l>
    <l>đ</l>
    <l>e</l>
    <l>f</l>
    <l>g</l>
    <l>h</l>
    <l>i</l>
    <l>j</l>
    <l>k</l>
    <l>l</l>
    <l>m</l>
    <l>n</l>
    <l>ŋ</l>
    <l>o</l>
    <l>p</l>
    <l>r</l>
    <l>s</l>
    <l>š</l>
    <l>t</l>
    <l>u</l>
    <l>v</l>
    <l>y</l>
    <l>z</l>
    <l>ž</l>
    <l>ä</l>
    <l>á</l>
  </xsl:variable>
  
  
  
  <xsl:template match="/" name="main">
    <!-- for each file in the inDir directory -->
    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      <xsl:variable name="file_name" select="substring-before($current_file, '.xml')"/>
      
      <xsl:if test="true()">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      <!--[]-->
      
      <xsl:variable name="current_doc" select="."/>
      
      <xsl:result-document href="{$outDir}/{$file_name}.{$of}" format="{$of}">
        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>Inarinsaame-suomi-sanakirja</title>
            <style>
	      body {
	      column-count: 2;
	      //column-rule: 1px solid black;
	      }
	    </style>
          </head>
          <body>
	    <!-- for each letter defined in the $abc variable in the defined order -->
	    <xsl:for-each select="$abc/l">
	      
	      <xsl:variable name="current_letter" select="."/>
	      
	      <div style="margin-left:1.1em;text-indent:-1.1em">
		<span style="font-size: 20px">
		  <b>
		    <xsl:value-of select="concat(upper-case($current_letter), $nl)"/>
		  </b>
		</span>
	      </div>
	      
	      <!-- for each entry that begins with the curren letter -->
	      <xsl:for-each select="$current_doc/r/e[starts-with(lower-case(normalize-space(./lg/l)), $current_letter)]">
		<xsl:sort select="./lg/l"
			  data-type="text"
			  order="ascending"
			  case-order="upper-first"/>
		
		<!--xsl:message terminate="no">
		  <xsl:value-of select="concat('x: ', ./lg/l)"/>
		</xsl:message-->
		
		
		<!-- process current entry -->
		<xsl:call-template name="processEntry">
	          <xsl:with-param name="entry" select="."/>
		</xsl:call-template>
	      </xsl:for-each>
	    </xsl:for-each>
	    
	  </body>
	</html>
      </xsl:result-document>
    </xsl:for-each>
    
  </xsl:template>
  
  <!-- process entry -->
  <xsl:template name="processEntry">
    <xsl:param name="entry"/>
    
    <xsl:message terminate="no">
      <xsl:value-of select="concat('e: ', $entry)"/>
    </xsl:message>
    
    <div style="margin-left:1.1em;text-indent:-1.1em">
      <span style="font-size: 12px">
	<b>
	  <xsl:value-of select="normalize-space($entry/lg/l)"/>
	</b>
      </span>
      
      <!-- pos -->
      <span style="font-size: 10px; vertical-align: super;">
	<i>
	  <xsl:value-of select="normalize-space($entry/lg/l/@pos)"/> <!--concat nedanfor-->
	</i>
      </span>
      
      <!-- boundary between left and right: one space -->
      <xsl:value-of select="' '"/>
      
      <xsl:for-each select="$entry/mg">
	<xsl:variable name="current_position" select="position()"/>
	<xsl:if test="count(../mg)&gt;1">
	  <span style="font-size: 10px;">
	    <b>
	      <xsl:value-of select="concat(' ', $current_position, '. ')"/> <!--concat nedanfor-->
	    </b>
	  </span>
	</xsl:if>
	<xsl:for-each select="./tg">
	  
	  <xsl:if test="./re and not(./re='')">
	    <span style="font-size: 12px; font-type: italics">
	      <i>
		<xsl:value-of select="concat(' (', normalize-space(./re),')')"/>
	      </i>
	    </span>
	  </xsl:if>
	  
	  <!-- translation -->
	  <span style="font-family: Century Schoolbook, arial, sans-serif; font-size: 12px">
	    <b>
	      <xsl:for-each select="./t">
		<xsl:value-of select="concat(' ', normalize-space(.))"/>
		
		<!-- pos -->
		<span style="font-size: 10px;  vertical-align: super;">
		  <i>
		    <xsl:value-of select="concat('',normalize-space(./@pos),'')"/>
		  </i>
		</span>
		
		<xsl:if test="not(position()=last())">
		  <span style="font-size: 12px">
		    <i>
		      <xsl:value-of select="', '"/>
		    </i>
		  </span>
		</xsl:if>
		
	      </xsl:for-each>
	    </b>
	  </span>
	  
	  
	  
	  <xsl:for-each select="./xg">
	    <span style="font-size: 12px; color: gray">
	      <xsl:value-of select="' ♦ '"/>
	    </span>
	    <span style="font-size: 12px">
	      <xsl:value-of select="concat(normalize-space(./x), ' ')"/>
	      <i>
		<xsl:value-of select="normalize-space(./xt)"/>
	      </i>
	    </span>
	  </xsl:for-each>
	  
	</xsl:for-each>
	<xsl:if test="not(position()=last())">
	  <span style="font-size: 12px">
	    <xsl:value-of select="'   '"/>
	  </span>
	</xsl:if>
      </xsl:for-each>
      
      <br/>
    </div>
    <br style="content: ' '; display: block; margin: 3px;"/>
    
    
  </xsl:template>
  
</xsl:stylesheet>
