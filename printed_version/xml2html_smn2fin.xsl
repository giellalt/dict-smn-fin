<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inDir=DIR
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

  
  <xsl:template match="/" name="main">

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
      
      <xsl:result-document href="{$outDir}/{$file_name}.{$of}" format="{$of}">
        <html>
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title>esp-sme ordbok</title>
          </head>
          <body>	    
	    <xsl:for-each select="./r/e">
	      <div style="margin-left:1.1em;text-indent:-1.1em">
		  <span style="font-size: 12px">
		    <b>
		      <xsl:value-of select="normalize-space(./lg/l)"/>
		    </b>
		  </span>

		  <!-- pos -->
		    <span style="font-size: 12px">
		      <i>
			<xsl:value-of select="concat(' [', normalize-space(./lg/l/@pos),']')"/>
		      </i>
		    </span>


		<xsl:if test="./mg/tg/re">
		  <span style="font-size: 12px">
		    <i>
		      <xsl:value-of select="concat(' [', normalize-space(./mg[1]/tg[1]/re),']')"/>
		    </i>
		  </span>
		</xsl:if>
		
		
		<!-- translation -->
		<span style="font-family: Century Schoolbook, arial, sans-serif; font-size: 12px">
		  <b>
		    <xsl:for-each select="./mg/tg/t">
		      <xsl:value-of select="concat(' ', normalize-space(.), ', ')"/>
		    </xsl:for-each>
		  </b>
		</span>

		<!-- pos -->
		  <span style="font-size: 12px">
		    <i>
		      <xsl:value-of select="concat(' [', normalize-space(./mg[1]/tg[1]/t[1]/@pos),']')"/>
		    </i>
		  </span>
		  
		  
		<xsl:for-each select="./mg/tg/xg">
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
		<br/>
	      </div>
	      <br style="content: ' '; display: block; margin: 3px;"/>
	    </xsl:for-each>
	  </body>
	</html>
      </xsl:result-document>
    </xsl:for-each>
    
</xsl:template>
  
</xsl:stylesheet>