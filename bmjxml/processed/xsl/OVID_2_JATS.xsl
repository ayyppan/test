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
	<!-- FRONT MATTER ENDS -->
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
    			 <xref>
					<xsl:attribute name="ref-type">				
			  			<xsl:text>aff</xsl:text>
					</xsl:attribute>
       				<xsl:attribute name="rid">
						<xsl:text>AF0001</xsl:text>
					</xsl:attribute>

	    		</xref>
    			
    			
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
            <xsl:value-of select="." /> 
        </day>
    </xsl:template>
    
    
    <xsl:template match="yr">
        <year>
            <xsl:value-of select="." /> 
        </year>
    </xsl:template>
   
    
	
    
    
    
    <!-- Month -->
     <xsl:template match="da/mo">
        <month>
            <xsl:call-template name="monthStr2Num">
                <xsl:with-param name="month" select="." />
            </xsl:call-template>
        </month>
    </xsl:template>
    <xsl:template name="monthStr2Num">
        <xsl:param name="month" />
        <xsl:choose>
            <xsl:when test="$month='Jan'">01</xsl:when>
            <xsl:when test="$month='Feb'">02</xsl:when>
            <xsl:when test="$month='Mar'">03</xsl:when>
            <xsl:when test="$month='Apr'">04</xsl:when>
            <xsl:when test="$month='May'">05</xsl:when>
            <xsl:when test="$month='Jun'">06</xsl:when>
            <xsl:when test="$month='Jul'">07</xsl:when>
            <xsl:when test="$month='Aug'">08</xsl:when>
            <xsl:when test="$month='Sep'">09</xsl:when>
            <xsl:when test="$month='Oct'">10</xsl:when>
            <xsl:when test="$month='Nov'">11</xsl:when>
            <xsl:when test="$month='Dec'">12</xsl:when>
            <xsl:when test="$month='January'">01</xsl:when>
            <xsl:when test="$month='February'">02</xsl:when>
            <xsl:when test="$month='March'">03</xsl:when>
            <xsl:when test="$month='April'">04</xsl:when>
            <xsl:when test="$month='May'">05</xsl:when>
            <xsl:when test="$month='June'">06</xsl:when>
            <xsl:when test="$month='July'">07</xsl:when>
            <xsl:when test="$month='August'">08</xsl:when>
            <xsl:when test="$month='September'">09</xsl:when>
            <xsl:when test="$month='October'">10</xsl:when>
            <xsl:when test="$month='November'">11</xsl:when>
            <xsl:when test="$month='December'">12</xsl:when>
            <xsl:when test="$month='01'">01</xsl:when>
            <xsl:when test="$month='02'">02</xsl:when>
            <xsl:when test="$month='03'">03</xsl:when>
            <xsl:when test="$month='04'">04</xsl:when>
            <xsl:when test="$month='05'">05</xsl:when>
            <xsl:when test="$month='06'">06</xsl:when>
            <xsl:when test="$month='07'">07</xsl:when>
            <xsl:when test="$month='08'">08</xsl:when>
            <xsl:when test="$month='09'">09</xsl:when>
            <xsl:when test="$month='10'">10</xsl:when>
            <xsl:when test="$month='11'">11</xsl:when>
            <xsl:when test="$month='12'">12</xsl:when>
            <xsl:when test="$month='1'">01</xsl:when>
            <xsl:when test="$month='2'">02</xsl:when>
            <xsl:when test="$month='3'">03</xsl:when>
            <xsl:when test="$month='4'">04</xsl:when>
            <xsl:when test="$month='5'">05</xsl:when>
            <xsl:when test="$month='6'">06</xsl:when>
            <xsl:when test="$month='7'">07</xsl:when>
            <xsl:when test="$month='8'">08</xsl:when>
            <xsl:when test="$month='9'">09</xsl:when>
            <xsl:when test="$month='10'">10</xsl:when>
            <xsl:when test="$month='11'">11</xsl:when>
            <xsl:when test="$month='12'">12</xsl:when>
            <xsl:otherwise>INVALID MONTH</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
 	
      
      
          
   
	 <!-- Month -->
	 <!-- <xsl:template name="da">
	 <month>
	 	<xsl:variable name="m">
	 	    <xsl:value-of select="./mo" />
	 	</xsl:variable>
	 	<xsl:choose>
			<xsl:when test="$m = 'january' or $m = 'January'">1</xsl:when>
			<xsl:when test="$m = 'february' or $m = 'February'">2</xsl:when>
			<xsl:when test="$m = 'march' or $m = 'March'">3</xsl:when>
			<xsl:when test="$m = 'april' or $m = 'April'">4</xsl:when>
			<xsl:when test="$m = 'may' or $m = 'May'">5</xsl:when>
			<xsl:when test="$m = 'june' or $m = 'June'">6</xsl:when>
			<xsl:when test="$m = 'july' or $m = 'July'">7</xsl:when>
			<xsl:when test="$m = 'august' or $m = 'August'">8</xsl:when>
			<xsl:when test="$m = 'september' or $m = 'September'">9</xsl:when>
			<xsl:when test="$m = 'october' or $m='October'">10</xsl:when>
			<xsl:when test="$m = 'november' or $m='November'">11</xsl:when>
			<xsl:when test="$m = 'december' or $m='December'">12</xsl:when>
		</xsl:choose>
		</month>
		</xsl:template>-->
	 	
	 
	 
	 
	 
	 
	 <!-- Month -->
    
     
   
    <!-- ============== --> 
    <!-- Aff-permission -->
    <!-- ============== --> 
    <!-- aff -->
    <!-- <xsl:template match="af/p">
    <xref>
	    <xsl:variable name="sp" select="./sp"/>
		<xsl:attribute name="ref-type">
			<xsl:text>aff</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="rid">
				<xsl:value-of select="$sp" />
		</xsl:attribute>	
	</xref>	
		
	</xsl:template>  
	 <xsl:template match="af/p/p">
    <xref>
	    <xsl:variable name="sp1" select="./sp"/>
		<xsl:attribute name="ref-type">
			<xsl:text>aff</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="rid">
				<xsl:value-of select="$sp1" />
		</xsl:attribute>	
	</xref>	
		
	</xsl:template>  -->
   
   
     <xsl:template match="af">
        <xref>
			<xsl:attribute name="ref-type">				
			  <xsl:text>aff</xsl:text>
			</xsl:attribute>
       		<xsl:attribute name="rid">
				<xsl:text>AF0001</xsl:text>
			</xsl:attribute>

	    </xref>
    </xsl:template>  
   
    <!-- ============== --> 
    <!-- Aff-permission -->
    
    <!-- ============== --> 
    
    <!-- =========== --> 
    <!-- Article doi -->
    <!-- =========== -->   
    
    
    
  
    
     
    
     <!--  block -->     	
   <xsl:template match="so">
     <article-meta>
      <xsl:variable name="t1" select="//xui/@ui"/>
      <xsl:variable name="t2" select="substring-before($t1,'/')"/>
      <xsl:variable name="t3" select="substring-after($t1,'/')"/>
      	<article-id pub-id-type="publisher-id"> 
      	
      		<xsl:value-of select="$t3" />
      	</article-id>
       	<article-id pub-id-type="doi"> 
      		<xsl:value-of select="$t1" />
      	
        </article-id>		
      	      		
      	
       
     </article-meta>
     </xsl:template>
     
     
     <xsl:template match="dt">     
     	 <article-categories>
				<subj-group>
	
					<subject>
					<xsl:apply-templates/>
					
					</subject>
				</subj-group>
			</article-categories> 
			<permissions>
			<copyright-statement>&#x00A9; 2015 American Federation for Medical Research, Published by the BMJ Publishing Group Limited. For permission to use (where not already granted under a licence) please go to http://group.bmj.com/group/rights-licensing/permissions</copyright-statement>
			<copyright-year>2015</copyright-year>
		</permissions>
    </xsl:template>
     
    

  		    		
          
   
    
    <!-- =========== --> 
    <!-- Article doi -->
    <!-- =========== --> 
    
       <!-- =========== --> 
    <!-- Fpage&Lpage -->
    <!-- =========== --> 
    
   
    
    <!--  page -->
 
         
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
	
	
	<xsl:template match="ab">
		<abstract>
		<xsl:apply-templates/>
		</abstract>
	</xsl:template>
	
	
    <xsl:template match="abs">
		<title>
		<xsl:apply-templates/>
		</title>			
		
    </xsl:template>
    
     <xsl:template match="ab/abs/hd">
		<sec>
		 <xsl:apply-templates/>	
		</sec>
    </xsl:template>
    <xsl:template match="ab/abs/hd/e[@t='B']">
		<title>
		 <xsl:apply-templates/>	
		</title>
    </xsl:template>
    <xsl:template match="ab/abs/p/e[@t='B']">
		<p>
		 <xsl:apply-templates/>	
		</p>
    </xsl:template>
    
    
   
 
    <xsl:template match="kws">
		<kwd-group>
			<xsl:apply-templates />
		</kwd-group>
    </xsl:template>
    <xsl:template match="kw">
		<kwd>
			<xsl:apply-templates />
		</kwd>
    </xsl:template>
    
    <xsl:template match="ti/e">
		<ArtTitle>
			<xsl:apply-templates />
		</ArtTitle>
    </xsl:template> 
   
   
  
    <xsl:template match="p">
		<p>
			<xsl:apply-templates />
		</p>
    </xsl:template>
    <xsl:template match="sp">
        <sup>
            <xsl:apply-templates />
        </sup>
    </xsl:template>
    <xsl:template match="sb">
        <sub>
            <xsl:apply-templates />
        </sub>
    </xsl:template>
    <xsl:template match="ls[@t='B']">
        <list list-type="bulleted">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='D']">
        <list list-type="dash">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='L']">
        <list list-type="alpha-lower">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='LCR']">
        <list list-type="roman-lower">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='UC']">
        <list list-type="alpha-upper">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='U']">
        <list list-type="simple">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="ls[@t='N']">
        <list list-type="order">
            <xsl:apply-templates />
        </list>
    </xsl:template>
    <xsl:template match="lm">
        <list-item>
            <xsl:apply-templates />
        </list-item>
    </xsl:template>
    
    <xsl:template match="e[@t='BUL']">
        <bold><underline>
            <xsl:apply-templates />
        </underline></bold>
    </xsl:template>
    <xsl:template match="e[@t='UL']">
        <underline>
            <xsl:apply-templates />
        </underline>
    </xsl:template>
    <!-- Institution -->
    <xsl:template match="af/p">
        <Address_line>
           <xsl:value-of select="./e[@t='I']"/>
        </Address_line>
    </xsl:template>
    <xsl:template match="bt/p">
        <Address_line>
             <xsl:value-of select="./e[@t='I']"/>
        </Address_line>
    </xsl:template>    
    <!-- Institution -->
    
    
    <xsl:template match="ti">
        <subtitle>
            <xsl:apply-templates />
        </subtitle>
    </xsl:template>
    <xsl:template match="ed">
        <ref-list>
            <xsl:apply-templates />
        </ref-list>
    </xsl:template>
    <xsl:template match="ed">
        <back>
            <xsl:apply-templates />
        </back>
    </xsl:template>
    <xsl:template match="bd">
        <body>
            <xsl:apply-templates />
        </body>
    </xsl:template>
    
    <xsl:template match="bd/hd/e[@t='B']">
        <title>
            <xsl:apply-templates />
        </title>
    </xsl:template>
     
    <xsl:template match="e[@t='BIT']">
        <bold><italic>
            <xsl:apply-templates />
        </italic></bold>
    </xsl:template> 

	<xsl:template match="e[@t='I']">
        <italic>
            <xsl:apply-templates />
        </italic>
    </xsl:template> 
    <xsl:template match="lv1/hd">
		 <xsl:variable name="wordfound" select="./e[@t='B']"/> 
		 <xsl:if  test="contains($wordfound, 'ACKNOWLEDGMENTS')">
		  <ack>
		  	<title>
		  		<xsl:value-of select="$wordfound"/>
		  	</title>
		  </ack>    
	     </xsl:if>
	</xsl:template>
    
    
     
     <xsl:template match="lv1|lv2|lv3|lv4|lv5">
        <sec>
            <xsl:apply-templates />
        </sec> 
    </xsl:template>    
    
    <xsl:template match="v">
        <volume>
            <xsl:apply-templates />
        </volume>
    </xsl:template>
    <xsl:template match="is">
        <issue>
            <xsl:apply-templates />
        </issue>
    </xsl:template>
    <xsl:template match="ip">
            <xsl:apply-templates />
    </xsl:template>
   <xsl:template match="rf">
        <ref>
            <xsl:attribute name="id">
		<xsl:value-of select="replace(@id, '^R0*', 'R')" />
            </xsl:attribute>
            <xsl:apply-templates />
        </ref>
        <mixed-citation public-type ="journal">      
        </mixed-citation>
    </xsl:template>    
    
    <xsl:template match="deg">
        <degrees>
            <xsl:apply-templates />
        </degrees>
    </xsl:template>
    
   
    
    <xsl:template match="da">
        <pub-date pub-type="ppub">
            <xsl:apply-templates />
        </pub-date>
    </xsl:template>
   
    <xsl:template match="by">
        <contrib-group>
            <xsl:apply-templates />
        </contrib-group>
    </xsl:template>
    <xsl:template match="dg">
        <article article-type="research-article">
            <xsl:apply-templates />
        </article>
    </xsl:template>
    
	<xsl:template match="d">
		<xsl:apply-templates />
	</xsl:template>
    <xsl:template match="tb">
        <table-wrap>
 			<xsl:attribute name="ID">
				<xsl:value-of select="./@id"/>
			</xsl:attribute>
          <xsl:apply-templates />
        </table-wrap>
      
    </xsl:template>

    <xsl:template match="bd/fg">
        <fig>
			<xsl:attribute name="ID">
				<xsl:value-of select="./@id"/>
			</xsl:attribute>
       			<xsl:attribute name="IMG">
				<xsl:value-of select="./@file"/>
			</xsl:attribute>

	    </fig>
    </xsl:template>
    <xsl:template match="tgp">
	<table frame="hsides"><tbody><tr><td>
        <graphic>
			<xsl:attribute name="xlink:href">
			    <xsl:variable name ="graphic" select="./@file"/>
				<xsl:variable name="g2" select="substring-after($graphic,'G')"/>	
			    <xsl:value-of select="$g2" />		    
			</xsl:attribute>
		</graphic>
        </td></tr></tbody></table>
    </xsl:template>
    <xsl:template match="url">
		<uri xlink:href=".">
            <xsl:apply-templates />
        </uri>
    </xsl:template>
  
    <xsl:template match="tb/ti">
      <xsl:variable name="p1" select="./e[@t='BIT']"/>
      <xsl:variable name="p2" select="substring-before($p1,'')"/>
      <xsl:variable name="p3" select="substring-after($p1,'')"/>
      	<label> 
      		<xsl:value-of select="$p2" />
      	</label>
       	<p> 
      		<xsl:value-of select="$p3" />
      	</p>
    </xsl:template>
    
    
    
    
    <!--  references  -->
    
    <xsl:template match="d">
		<xsl:apply-templates />
	</xsl:template>
    <xsl:template match="tb">
        <table-wrap>
 			<xsl:attribute name="ID">
				<xsl:value-of select="./@id"/>
			</xsl:attribute>
          <xsl:apply-templates />
        </table-wrap>
    </xsl:template>
    
    
    <!--  references Figure -->
    <xsl:template match="fg/p/e[@t='BIT']">
       <label>         
         <xsl:apply-templates />
        </label>
    </xsl:template>
    
    <!--  references Figure -->
    <xsl:template match="fg/p/e[@t='I']">
       <p>
          
          <xsl:apply-templates />
        </p>
    </xsl:template>


     <!--  references Fig -->
    
    <xsl:template match="d">
		<xsl:apply-templates />
	</xsl:template>
    <xsl:template match="fg">
        <fig>
 			<xsl:attribute name="ID">
				<xsl:value-of select="./@id"/>
			</xsl:attribute>
          <xsl:apply-templates />
        </fig>
    </xsl:template>
    
    
    
    <!--  Add Sup -->
    

	<!-- handle citations -->
	<xsl:template match="lk">
		<sup>
		<xref>
			<xsl:choose>
				<xsl:when test="starts-with(@idref, 'T')">
					<xsl:attribute name="ref-type">
						<xsl:text>table</xsl:text>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="starts-with(@idref, 'F')">
					<xsl:attribute name="ref-type">
						<xsl:text>fig</xsl:text>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
				
					<xsl:attribute name="ref-type">
						<xsl:text>bibr</xsl:text>
					</xsl:attribute>
				
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="rid">
				<xsl:value-of select="./@idref" />
			</xsl:attribute>
			
			
			<xsl:apply-templates />
		</xref>
		</sup>
	</xsl:template>
	<!-- handle citations ends -->

	<!-- ============== -->	
	<!-- GENERAL STARTS -->	
	<!-- ============== -->	
	<!-- remove unwanted tags but retain child nodes -->
	<xsl:template match="body|pb|isn|tg/ti/e|bb/xui|bb/cp">
		<xsl:apply-templates />
	</xsl:template>

	<!-- Remove empty tags -->
    <xsl:template match="@xlink:type" />

	<!-- ============== -->	
	<!-- GENERAL ENDS -->	
	<!-- ============== -->	
</xsl:stylesheet>

