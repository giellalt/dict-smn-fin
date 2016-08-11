<?xml version="1.0"?>
<!--+
    | 
    | change the 2004-xml-spreadsheet XML files into a simpler xml format
    | Usage: java net.sf.saxon.Transform -it main STYLESHEET_NAME.xsl (inFile=INPUT_FILE_NAME.xml | inDir=INPUT_DIR)
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:local="nightbar"
                xmlns:misc="someURI"
                xmlns:File="java:java.io.File"
		xmlns:fmp="http://www.filemaker.com/fmpxmlresult"
		xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
		exclude-result-prefixes="xs local fmp ss File misc">

  <xsl:strip-space elements="*"/>

  <xsl:output method="xml" name="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
              indent="yes"/>
  <xsl:output method="xml" name="html"
              encoding="UTF-8"
              omit-xml-declaration="yes"
              indent="yes"/>
  <xsl:output method="text" name="txt"
	      encoding="UTF-8"/>
  
  <!-- in -->
  <xsl:param name="inDir" select="'indira'"/>
  <xsl:param name="this" select="base-uri(document(''))"/>
  <xsl:variable name="this_name" select="(tokenize($this, '/'))[last()]"/>

  <!-- out -->
  <xsl:param name="cIndex" select="'2'"/>
  <xsl:param name="outDir" select="concat('out_stuff_', $cIndex)"/>
  
  <xsl:variable name="oe" select="'txt'"/>
  <xsl:variable name="tb" select="'&#9;'"/>
  <xsl:variable name="nl" select="'&#xA;'"/>
  <xsl:variable name="debug" select="false()"/>  

  <xsl:template match="/" name="main">
    
      
      <xsl:for-each select="for $f in collection(concat($inDir, '?select=*.xml;recurse=no;on-error=warning')) return $f">
	
	<xsl:variable name="current_file" select="substring-before((tokenize(document-uri(.), '/'))[last()], '.xml')"/>
	<xsl:variable name="current_dir" select="substring-before(document-uri(.), $current_file)"/>
	<xsl:variable name="current_location" select="concat($inDir, substring-after($current_dir, $inDir))"/>
	
	<xsl:call-template name="processFile">
	  <xsl:with-param name="file" select="."/>
	  <xsl:with-param name="name" select="$current_file"/>
	  <xsl:with-param name="ie" select="'xml'"/>
	  <xsl:with-param name="relPath" select="$current_location"/>
	  
	</xsl:call-template>
      </xsl:for-each>
    
  </xsl:template>

  <!-- template to process file, once its existence has been determined -->
  <xsl:template name="processFile">
    <xsl:param name="file"/>
    <xsl:param name="name"/>
    <xsl:param name="ie"/>
    <xsl:param name="relPath"/>

    <xsl:message terminate="no">
      <xsl:value-of select="concat('Processing file: ', $relPath, $name, '.', $ie)"/>
    </xsl:message>      
    
    <!-- out -->
    <xsl:result-document href="{$outDir}/{$name}.{$oe}" format="{$oe}">
      
      <xsl:value-of select="'ID SMN lemma pos: mg1 (=t1,t2,tX); mg2 (=t1,t2,tX); mgX  (=t1,t2,tX); placeholder for action tag'"/>
      <xsl:value-of select="$nl"/>
	<xsl:for-each select="$file//e">
	  <xsl:variable name="c_id" select="./@id"/>
	  <xsl:variable name="c_l" select="./lg/l"/>
	  <xsl:variable name="c_pos" select="./lg/l/@pos"/>
	  
	  <xsl:message terminate="no">
	    <xsl:value-of select="concat('Processing e: ', $c_id, $nl)"/>
	  </xsl:message> 

	  <xsl:variable name="all_mgs">
	    <xsl:for-each select="./mg">
	      <xsl:if test="./@rest and not(./@rest='')">
		<xsl:value-of select="concat('[LEMMA ', ./@rest, '] ')"/>
	      </xsl:if>
	      <xsl:for-each select="./tg/t">
		<xsl:if test="./@pos=$c_pos">
		  <xsl:value-of select="."/>
		</xsl:if>
		<xsl:if test="not(./@pos=$c_pos)">
		  <xsl:value-of select="concat(., ' /', ./@pos, '/')"/>
		</xsl:if>
		<xsl:if test="not(position()=last())">
		  <xsl:value-of select="', '"/>
		</xsl:if>
	      </xsl:for-each>
	      <xsl:if test="not(position()=last())">
		<xsl:value-of select="'; '"/>
	      </xsl:if>
	    </xsl:for-each>
	  </xsl:variable>

	  <!-- output csv -->
	  <xsl:value-of select="concat($c_id, ' ', $c_l,
				': ', $all_mgs, ' _ ')"/>
	  <xsl:value-of select="$nl"/>
	  
	</xsl:for-each>

    </xsl:result-document>
    
    <xsl:if test="$debug">
      <xsl:message terminate="no">
	<xsl:value-of select="concat('   Done!',' Output file  ',$name,' in: ', $outDir)"/>
      </xsl:message>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>

