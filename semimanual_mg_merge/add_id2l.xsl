<?xml version="1.0"?>
<!--+
    | Usage: java -Xmx2048m net.sf.saxon.Transform -it main THIS_FILE inputDir=DIR
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:xhtml="http://www.w3.org/1999/xhtml"
		exclude-result-prefixes="xs xhtml">

  <xsl:strip-space elements="*"/>
  <!--   <xsl:preserve-space elements="lics lic sourcenote"/> -->
  <xsl:output method="xml" name="xml"
	      encoding="UTF-8"
	      omit-xml-declaration="no"
	      indent="yes"/>
  
  <xsl:param name="inDir" select="'0_inc'"/>
  <xsl:variable name="outDir" select="'1_eid'"/>
  <xsl:variable name="of" select="'xml'"/>
  <xsl:variable name="e" select="$of"/>
  <xsl:variable name="debug" select="true()"/>
  <xsl:variable name="nl" select="'&#xa;'"/>

  <xsl:template match="/" name="main">
    <xsl:for-each select="for $f in collection(concat($inDir,'?recurse=no;select=*.xml;on-error=warning')) return $f">
      
      <xsl:variable name="current_file" select="(tokenize(document-uri(.), '/'))[last()]"/>
      <xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
      <xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
      
      <xsl:if test="$debug">
	<xsl:message terminate="no">
	  <xsl:value-of select="concat('-----------------------------------------', $nl)"/>
	  <xsl:value-of select="concat('processing file ', $current_file, $nl)"/>
	  <xsl:value-of select="'-----------------------------------------'"/>
	</xsl:message>
      </xsl:if>
      
      <xsl:result-document href="{$outDir}/{$current_file}" format="{$of}">
	<r>
	  <xsl:copy-of select="./r/@*"/>
	  <xsl:for-each select="./r/e">

	    <xsl:if test="$debug">
	      <xsl:message terminate="no">
		<xsl:value-of select="concat('....................processing lemma ', ./lg/l, $nl)"/>
	      </xsl:message>
	    </xsl:if>
	    
	    <e id="{concat(./lg/l/@pos, '_', position())}">
	      <xsl:copy-of copy-namespaces="no" select="./@*"/>
	      <xsl:copy-of copy-namespaces="no" select="./*"/>
	    </e>
	  </xsl:for-each>
	</r>
      </xsl:result-document>
    </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
