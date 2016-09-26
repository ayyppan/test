<?xml version="1.0" encoding="utf-8"?>
<!-- Created with Liquid XML Studio Developer Edition (Trial) 9.0.11.3078 (http://www.liquid-technologies.com) -->
<xsl:stylesheet version="2.0" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:oasis="http://www.oasis-open.org" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ln="http://www.lexisnexis.at/xhtml-cals" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ds="http://www.daisy.org/z3986/2005/ncx/" exclude-result-prefixes="mml xsi oasis functx xs ds ln xlink mml xsi">
    
    <!--<xsl:strip-space elements="*"/>-->
    <!-- <xsl:include href="//winas.exeterpm.in/scripts/Indesign/XSLT/CharacterMaps_Named.xsl" /> -->
    <xsl:output method="xml" indent="yes" use-character-maps="namedConv" doctype-public="-//NLM//DTD JATS (Z39.96) Journal Publishing DTD v1.1d1 20130915//EN" doctype-system="JATS-journalpublishing1.dtd" />
    <!-- <xsl:character-map name="namedConv" use-character-maps="namedEntity" /> -->
    
	<!-- base transformation block -->
	<xsl:template match="@* | node(  )">
		<xsl:copy>
			<xsl:apply-templates select="@* | node(  )"/>
		</xsl:copy>	
		
	</xsl:template>


	<!-- ================= -->
	<!-- FRONT MATTER START -->
	<!-- ================= -->
	
	
	 	<xsl:template match="html">
		<article article-type="research-article" xmlns:xlink="http://www.w3.org/1999/xlink">
			<xsl:apply-templates />
		</article>
	</xsl:template>

    <xsl:template match="bb">
        <front>
			<journal-meta>
				<journal-id journal-id-type="nlm-ta">
					<xsl:value-of select="//pb" />
				</journal-id>
				<journal-id journal-id-type="publisher-id">jim</journal-id>
				<journal-id journal-id-type="hwp">jim</journal-id>
				<journal-title-group>
					<journal-title><xsl:value-of select="//pb" /></journal-title><abbrev-journal-title>J Investig Med</abbrev-journal-title>
				</journal-title-group>
				<issn pub-type="ppub"><xsl:value-of select="//isn" /></issn>
				<issn pub-type="epub">1708-8267</issn>
				<publisher>
					<publisher-name>BMJ Publishing Group Ltd.</publisher-name>
					<publisher-loc>BMA House, Tavistock Square, London, WC1H 9JR</publisher-loc>
				</publisher>
			</journal-meta>
            <xsl:apply-templates />
        </front>
    </xsl:template> 

   
    <!--  title  -->
   <xsl:template match="tg">
    	<title-group>
    		<xsl:apply-templates />
    	</title-group>
    </xsl:template>
    <xsl:template match="tg/ti">
    	<article-title>
    		<xsl:apply-templates />
    	</article-title>
    </xsl:template>

    
    <xsl:template match="bt">
        <author-notes>
        	<corresp>
            	<xsl:apply-templates />
            </corresp>
        </author-notes>
    </xsl:template>  
    
    
    
   
   
    <!-- Contribute Group -->
  

    
    <xsl:template match="pn">
    	<contrib contrib-type="author">
    		<name>
    			<surname>
    				<xsl:apply-templates select="./sn" mode="nameMode"/>
    			</surname>
    			<given-names>
    				<xsl:apply-templates select="./fn" mode="nameMode"/>
    				<xsl:if test="./mn">
    					<xsl:text> </xsl:text>
    				</xsl:if>
    				<xsl:apply-templates select="./mn" mode="nameMode"/>
    			</given-names>
    			
    			<xsl:apply-templates />
    		</name>
    	</contrib>
    </xsl:template> 
    
       <xsl:template match="tb/ti">
    <caption> 
		<xsl:apply-templates />
	</caption>	
	</xsl:template>

	<xsl:template match="sn|fn|mn" mode="nameMode">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="sn|fn|mn" />  
  
 	 <!-- publish date -->
 	<xsl:template match="dy">
        <day>
            <xsl:apply-templates />
        </day>
    </xsl:template>
    
    
    <xsl:template match="yr">
        <year>
            <xsl:apply-templates />
        </year>
    </xsl:template>
    
    
   
 	
      
      
   
     
    
    <!-- ============== --> 
    <!-- Aff-permission -->
    <!-- ============== --> 
    
    <xsl:template match="cp">
		<permissions>
			<copyright-statement>&#x00A9; 2015 American Federation for Medical Research, Published by the BMJ Publishing Group Limited. For permission to use (where not already granted under a licence) please go to http://group.bmj.com/group/rights-licensing/permissions</copyright-statement>
			<copyright-year>2015</copyright-year>
		</permissions>
    </xsl:template>
    
  
    <xsl:template match="af">
        <aff id="AF0001">
        </aff>
    </xsl:template>    
    
    <!-- ============== --> 
    <!-- Aff-permission -->
    
    <!-- ============== --> 
    
    <!-- =========== --> 
    <!-- Article doi -->
    <!-- =========== -->    
    
     <!--  block -->     	
    
  		    		
          
   
    
    <!-- =========== --> 
    <!-- Article doi -->
    <!-- =========== --> 
    
       <!-- =========== --> 
    <!-- Fpage&Lpage -->
    <!-- =========== --> 
    

         
   	<!-- =========== --> 
    <!-- Fpage&Lpage -->
    <!-- =========== --> 
     
     
 
    
   
    
       
   
	<!-- ================= -->
	<!-- FRONT MATTER ENDS -->
	<!-- ================= -->

    <!-- date conversions-->
    <xsl:param name="contribid" select="number(1)" />
    <xsl:variable name="journalID" select="string(//journal-id)" />
    <xsl:template match="@* | node(  )">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node(  )" />
        </xsl:copy>
    </xsl:template>
    
    <!--  class to tag conversion -->
    <xsl:template match="*[@class]">
		<xsl:variable name="className">
			<xsl:value-of select="@class"/>
		</xsl:variable>
		<xsl:choose>
			<!-- if there are multiple class names then convert them into untagged node -->
			<xsl:when test="contains($className, ' ')">
				<jrnlUnTagged>
					<xsl:apply-templates select="@* | node()"/>
				</jrnlUnTagged>
			</xsl:when>
			<!-- if the class name is not null then create a tag using the class name -->
			<xsl:when test="$className != ''">
				<xsl:element name="{$className}">
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@* | node(  )"/>
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
   
	<!-- handle citations ends -->

	<!-- ============== -->	
	<!-- GENERAL STARTS -->	
	<!-- ============== -->	

	<!-- ============== -->	
	<!-- GENERAL ENDS -->	
	<!-- ============== -->	
</xsl:stylesheet>

