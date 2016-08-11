<?xml version="1.0"?>

<!--+
    | Transforms a csv file with two fields - "lemma","part-of-speech", etc. - into a sma oahpa gtdict xml format
    | NB: An XSLT-2.0-processor is needed!
    | Usage: java -Xmx2024m net.sf.saxon.Transform -it main THIS_SCRIPT file="INPUT-FILE"
    | 
    +-->

<xsl:stylesheet version="2.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
		xmlns:functx="http://www.functx.com"
		xmlns:fn="fn"
		xmlns:local="nightbar"
		exclude-result-prefixes="xs fn local functx">
  
  <xsl:strip-space elements="*"/>
  <xsl:output method="xml"
              encoding="UTF-8"
              omit-xml-declaration="no"
	      indent="yes"/>
  
<xsl:function name="local:distinct-deep" as="node()*">
  <xsl:param name="nodes" as="node()*"/> 
 
  <xsl:sequence select=" 
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(local:is-node-in-sequence-deep-equal(
                          .,$nodes[position() &lt; $seq]))]
 "/>
</xsl:function>

<xsl:function name="local:is-node-in-sequence-deep-equal" as="xs:boolean">
  <xsl:param name="node" as="node()?"/> 
  <xsl:param name="seq" as="node()*"/> 
 
  <xsl:sequence select=" 
   some $nodeInSeq in $seq satisfies deep-equal($nodeInSeq,$node)
 "/>
   
</xsl:function>

<xsl:function name="functx:index-of-string-first" as="xs:integer?"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  if (contains($arg, $substring))
  then string-length(substring-before($arg, $substring))+1
  else ()
 "/>

</xsl:function>

<xsl:function name="functx:index-of-string-last" as="xs:integer?"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  functx:index-of-string($arg, $substring)[last()]
 "/>

</xsl:function>

<xsl:function name="functx:index-of-string" as="xs:integer*"
              xmlns:functx="http://www.functx.com">
  <xsl:param name="arg" as="xs:string?"/>
  <xsl:param name="substring" as="xs:string"/>

  <xsl:sequence select="
  if (contains($arg, $substring))
  then (string-length(substring-before($arg, $substring))+1,
        for $other in
           functx:index-of-string(substring-after($arg, $substring),
                               $substring)
        return
          $other +
          string-length(substring-before($arg, $substring)) +
          string-length($substring))
  else ()
 "/>

</xsl:function>




  <xsl:variable name="e" select="'xml'"/>
  <xsl:variable name="outputDir" select="'out-xml'"/>

  <xsl:param name="inFile" select="'inc/fellesliste.txt'"/>
  <xsl:variable name="lf" select="'&#xa;'"/>
  <xsl:variable name="cr" select="'&#xd;'"/>
  <xsl:variable name="tb" select="'&#x9;'"/>
  <xsl:variable name="sp" select="'&#x20;'"/>
  <xsl:variable name="nbs1" select="'&#xa0;'"/>
  <xsl:variable name="nbs2" select="'&#160;'"/>
 <xsl:variable name="f_pos" select="'N'"/> 

  <xsl:variable name="regex">^([^	]+)	+([^	]+)	+([^	]+)	+(.*$)</xsl:variable>

<!--   <xsl:variable name="regex">^([^$tb]+)+$tb+([^$tb]+)(.*$)</xsl:variable> -->

  <xsl:template match="/" name="main">
    
    <xsl:choose>
      <xsl:when test="unparsed-text-available($inFile)">

	<xsl:variable name="file_name" select="substring-before($inFile, '.txt')"/>

	<xsl:variable name="source" select="unparsed-text($inFile)"/>
	<xsl:variable name="lines" select="tokenize($source, $lf)" as="xs:string+"/>
	<xsl:variable name="output">
	  <r>
	    <!-- capture the patterns and their meanings -->
	    <xsl:for-each select="$lines">
	      <xsl:if test="not(normalize-space(.)='')">
	      <xsl:variable name="l_p" select="normalize-space(substring-before(.,':'))"/>
	      <xsl:variable name="t_p" select="normalize-space(substring-after(.,':'))"/>
	      
	      <xsl:variable name="l" select="substring($l_p,1,functx:index-of-string-last($l_p,' ')-1)"/>
	      <xsl:variable name="pos" select="substring($l_p,functx:index-of-string-last($l_p,' ')+1,functx:index-of-string-last($l_p,' ')-1)"/>
	      
	      <e>
		<lg>
		  <l>
		    <xsl:attribute name="pos">
		      <xsl:value-of select="$pos"/>
		    </xsl:attribute>
		    <xsl:value-of select="$l"/>
		  </l>
		</lg>
		<xsl:for-each select="tokenize($t_p, ';')">
		  <xsl:variable name="c_pair" select="normalize-space(.)"/>
		  <xsl:variable name="t" select="substring($c_pair,1,functx:index-of-string-last($c_pair,' ')-1)"/>
		  <xsl:variable name="p" select="substring($c_pair,functx:index-of-string-last($c_pair,' ')+1,functx:index-of-string-last($c_pair,' ')-1)"/>
		  <mg>
		    <tg>
		      <t pos="{$p}" xml:lang="nob">
			<xsl:value-of select="$t"/>
		      </t>
		    </tg>
		  </mg>
		</xsl:for-each>
		
		
		<!-- <mg> -->
		<!--   <tg> -->
		<!--     <xsl:for-each select="tokenize($trans, ';')"> -->
		<!--       <t pos="{lower-case($current_pos[1])}" xml:lang="nob"> -->
		<!-- 	<xsl:value-of select="normalize-space(.)"/> -->
		<!--       </t> -->
		<!-- 	</xsl:for-each> -->
		<!--       </tg> -->
		<!--     </mg> -->

		    <!-- the correct method -->
		    <!-- 		    <xsl:for-each select="tokenize($trans, ';')"> -->
		    <!-- 		      <mg> -->
		    <!-- 			<tg> -->
		    <!-- 			  <xsl:for-each select="tokenize(., ',')"> -->
		    <!-- 			    <t pos="xxx" xml:lang="nob"> -->
		    <!-- 			      <xsl:value-of select="normalize-space(.)"/> -->
		    <!-- 			    </t> -->
		    <!-- 			  </xsl:for-each> -->
		    <!-- 			</tg> -->
		    <!-- 		      </mg> -->
		    <!-- 		    </xsl:for-each> -->

	      </e>
	      </xsl:if>
	    </xsl:for-each>
	  </r>
	</xsl:variable>

	<!-- output -->
	<xsl:result-document href="{$outputDir}/{$f_pos}_smenob.{$e}">
	  <xsl:copy-of select="$output"/>
	</xsl:result-document>
	
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>Cannot locate : </xsl:text><xsl:value-of select="$inFile"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>

