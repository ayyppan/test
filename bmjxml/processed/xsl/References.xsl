<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:oasis="http://docs.oasis-open.org/ns/oasis-exchange/table" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="mml xsi oasis xs xlink mml xsi">

	<xsl:output method="html" indent="no" encoding="utf-8" />

	<xsl:template match="@* | node(  )">
		<xsl:copy>
			<xsl:apply-templates select="@* | node(  )"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="div[@class='WordSection1']">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="div[@contenteditable='false']|div[@id='commentDivNode']" />

	<xsl:template match="html">
		<book xmlns:mml="http://www.w3.org/1998/Math/MathML" xmlns:xlink="http://www.w3.org/1999/xlink" xml:lang="EN">
			<book-meta>
				<book-id pub-id-type="doi">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookDoi']"/>
				</book-id>
				<book-id pub-id-type="publisher-id">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookPubID']"/>
				</book-id>
				<book-title-group>
					<book-title>
						<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookTitle']"/>
					</book-title>
				</book-title-group>
				<isbn pub-type="ppub">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookPpub']"/>
				</isbn>
				<isbn pub-type="epub">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookEpub']"/>
				</isbn>
			</book-meta>
		<body>
			<book-part book-part-type="chapter">
				<xsl:apply-templates/>
			</book-part>
		</body>
		</book>
	</xsl:template>

	<xsl:template match="body">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="div[@class='front']">
		<book-part-meta>
		
			<book-part-id pub-id-type="doi">
				<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookDoi']"/><xsl:text>-</xsl:text>
				<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookArtID']"/>
			</book-part-id>
			<book-part-id pub-id-type="publisher-id">
				<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookArtID']"/>
			</book-part-id>
			<book-part-id pub-id-type="other">
				<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookPartPubOther']"/>
			</book-part-id>
			<title-group>
				<title>
					<xsl:apply-templates select="h1[@class='jrnlArtTitle']" mode="jrnlArtTitleMode"/>
				</title>
				<alt-title alt-title-type="running-head">
					<xsl:apply-templates select="h1[@class='jrnlArtTitle']" mode="jrnlArtTitleMode"/>
				</alt-title>
			</title-group>
			<contrib-group>
				<xsl:apply-templates select="p[@class='jrnlAuthors']" mode="jrnlAuthorsMode"/>
				<xsl:apply-templates select="div[@class='jrnlAffGroup']" mode="jrnlAffGroupMode"/>
			</contrib-group>

			<pub-date>
				<year>
					<!-- <xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookPubYear']"/> -->
					<xsl:text>2015</xsl:text>
				</year>
			</pub-date>
			<fpage>
				<xsl:value-of select="//filefpg"/>
				<xsl:variable name="firstPageC" select="//filefpt"/>
			</fpage>
			<lpage>
				<xsl:value-of select="//filelpg"/>
			</lpage>
			<history>
				<string-date content-type="epub">
<!--					<xsl:apply-templates select="//table[@class='meta']/tbody/tr/td[@class='bookHisEpub']"/>-->
						<xsl:text>xx/xx/xxxx</xsl:text>
					</string-date>
				<string-date content-type="qaapprove">
				<!--	<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookHisQa']"/> -->
						<xsl:text>xx/xx/xxxx</xsl:text>

					</string-date>
			</history>
			<permissions>
				<copyright-statement>(c1) Taylor &amp; Francis. All rights reserved.</copyright-statement>
				<copyright-holder>T&amp;F</copyright-holder>
			</permissions>
				<alternate-form>
					<xsl:attribute name="alternate-form-type">
						<xsl:text>pdf</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="xlink:href">
						<xsl:text>pdf/</xsl:text>
						<xsl:value-of select="//table/tbody/tr/td[@class='bookArtID']"/>
						<xsl:text>.pdf</xsl:text>
					</xsl:attribute>
				</alternate-form>

		<!--	<alternate-form alternate-form-type="pdf" xlink:href="pdf/120047359.pdf"/>-->
			
			<abstract xml:lang="EN">
				<title>
					<xsl:apply-templates select="//h1[@class='jrnlAbsHead']" mode="jrnlAbsHeadMode"/>
				</title>
				<xsl:for-each select="//p[@class='jrnlAbsPara']">
					<p><xsl:apply-templates select="//p[@class='jrnlAbsPara']" mode="jrnlAbsParaMode"/></p>
				</xsl:for-each>
				</abstract>
<kwd-group kwd-group-type="author">
<title>Keywords</title>
				<kwd/>
				<xsl:for-each select="//p[@class='jrnlKeywordPara']">
					<!-- <kwd><xsl:value-of select="//p[@class='jrnlKeywordPara']"/></kwd> -->
					<xsl:apply-templates/>
					
				</xsl:for-each>

</kwd-group>			
<counts>
			<fig-count>
				<xsl:attribute name="count">
					<xsl:value-of select="//figcnt"/>
				</xsl:attribute>
			</fig-count>
			<table-count>
				<xsl:attribute name="count">
					<xsl:value-of select="//tblcnt"/>
				</xsl:attribute>
			</table-count>
			<ref-count>
				<xsl:attribute name="count">
					<xsl:value-of select="//refscount"/>
				</xsl:attribute>
			</ref-count>
			<page-count>
				<xsl:attribute name="count">
					<xsl:value-of select='//totPags'/>
				</xsl:attribute>
			</page-count>
			</counts>
			<custom-meta-group>
			<custom-meta>
			<meta-name>Tagger</meta-name>
			<meta-value>Exeter</meta-value>
			</custom-meta>
			</custom-meta-group>
		</book-part-meta>
	</xsl:template>

	<xsl:template match="//h1[@class='jrnlArtHead']"/>
	<xsl:template match="//h1[@class='jrnlAbsHead']" mode="jrnlAbsHeadMode">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="//p[@class='jrnlAbsPara']"/>
	<xsl:template match="//p[@class='jrnlAbsPara']" mode="jrnlAbsParaMode">
		<xsl:apply-templates/>
	</xsl:template>

	
	<xsl:template match="h1[@class='jrnlArtTitle']"/>
	<xsl:template match="h1[@class='jrnlArtTitle']" mode="jrnlArtTitleMode">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="p[@class='jrnlAuthors']" mode="jrnlAuthorsMode">
		<xsl:apply-templates/>
	</xsl:template>
	
<!--	<xsl:template match="span[@class='jrnlAuthors']">
		<xsl:apply-templates/>
	</xsl:template>
-->



	<xsl:template match="contrib">
		<contrib contrib-type="author">
			<xsl:apply-templates/>
		</contrib>
	</xsl:template>
	<xsl:template match="span[@class='jrnlAuthor']/text()|contrib/text()|span[@class='RefAuthor']/text()|p[@class='jrnlAuthors']/text()">
	</xsl:template>
	<xsl:template match="span[@class='jrnlAuthor']">
		<string-name>
			<xsl:apply-templates/>
		</string-name>
	</xsl:template>


	<xsl:template match="span[@class='Comments']">
		<comment>
			<xsl:apply-templates/>
		</comment>
	</xsl:template>

	<xsl:template match="span[@class='RefSource']">
		<source>
			<xsl:apply-templates/>
		</source>
	</xsl:template>




	<xsl:template match="span[@class='jrnlGivenName']">
		<given-names>
			<xsl:apply-templates/>
		</given-names>
	</xsl:template>
	<xsl:template match="span[@class='jrnlSurName']">
		<surname>
			<xsl:apply-templates/>
		</surname>
	</xsl:template>
	<!-- xref aff-->
	<xsl:template match="xref[@ref-type='aff']">
		<xref ref-type="aff" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>

	<xsl:template match="contrib/sup">
			<xref>
			<xsl:attribute name="ref-type">
				<xsl:text>aff</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="rid">
			<xsl:text>AF000</xsl:text>
			<xsl:value-of select="//contrib/sup"/>
			</xsl:attribute>
			</xref>
		</xsl:template> 

	

		
	<xsl:template match="span[@class='jrnlAddrLine']">
		<address>
			<!--<addr-line content-type="zip">-->
				<xsl:apply-templates/>
			<!--</addr-line>-->
		</address>
	</xsl:template>

	<xsl:template match="div[@class='jrnlAffGroup']"/>
	<xsl:template match="div[@class='jrnlAffGroup']" mode="jrnlAffGroupMode">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="p[@class='jrnlAff']">
		<aff id="{@id}">
			<institution>
			<xsl:apply-templates select=".//span[@class='jrnlDepartment']" mode="affInstitute"/>
			<xsl:apply-templates select=".//span[@class='jrnlInstitution']" mode="affInstitute"/>
			<xsl:apply-templates select=".//span[@class='jrnlCity']" mode="affInstitute"/>
			<xsl:apply-templates select=".//span[@class='jrnlState']" mode="affInstitute"/>
			</institution>
			<xsl:apply-templates select="span[@class='jrnlCountry']" />
		</aff>
	</xsl:template>
<xsl:template match="contrib/span[@class='jrnlAffRef']">
		<xref ref-type="aff" rid="{@id}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>

<xsl:template match="span[@class='jrnlAffRef']">
		<xref ref-type="aff" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>

	<xsl:template match="span[@class='jrnlDepartment']" />
	<xsl:template match="span[@class='jrnlDepartment']" mode="affInstitute">
		<named-content content-type="dept">
			<xsl:apply-templates/>
		</named-content>
	</xsl:template>

	<xsl:template match="span[@class='jrnlInstitution']" />
	<xsl:template match="span[@class='jrnlInstitution']" mode="affInstitute">
		<named-content content-type="institutionname">
			<xsl:apply-templates/>
		</named-content>
	</xsl:template>

	<xsl:template match="span[@class='jrnlCity']" />
	<xsl:template match="span[@class='jrnlCity']" mode="affInstitute">
		<named-content content-type="city">
			<xsl:apply-templates/>
		</named-content>
	</xsl:template>

	<xsl:template match="span[@class='jrnlState']" />
	<xsl:template match="span[@class='jrnlState']" mode="affInstitute">
		<named-content content-type="state">
			<xsl:apply-templates/>
		</named-content>
	</xsl:template>

	<xsl:template match="span[@class='jrnlCountry']">
		<country>
			<xsl:apply-templates/>
		</country>
	</xsl:template>

	<xsl:template match="span[@class='jrnlTelephone']">
		<phone>
			<xsl:apply-templates/>
		</phone>
	</xsl:template>
	<xsl:template match="span[@class='jrnlFax']">
		<fax>
			<xsl:apply-templates/>
		</fax>
	</xsl:template>
	<xsl:template match="span[@class='jrnlEmail']">
		<email>
			<xsl:apply-templates/>
		</email>
	</xsl:template>

	<!-- Corresponding Affiliation STARTS -->
	<xsl:template match="div[@class='jrnlCorrAffGroup']"/>
	<xsl:template match="div[@class='jrnlCorrAffGroup']" mode="jrnlCorrAffGroupMode">
		<author-notes>
			<xsl:apply-templates/>
		</author-notes>
	</xsl:template>
	<xsl:template match="p[@class='jrnlCorrAff']">
		<corresp id="{@id}">
			<xsl:apply-templates/>
		</corresp>
	</xsl:template>
	<!-- Corresponding Affiliation ENDS -->

	
	<!-- Abstract STARTS -->
	<xsl:template match="div[@class='Abstract']">
		<abstract>
			<xsl:apply-templates/>
		</abstract>
	</xsl:template>
	<xsl:template match="h1[@class='jrnlAbsHead']">
		<title>
			<xsl:apply-templates/>
		</title>
	</xsl:template>
	<xsl:template match="p[@class='jrnlAbsPara']">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<!-- Abstract ENDS -->
	

<!-- Keyword STARTS -->
<!--

<xsl:template match="div[@class='jrnlKeyword']">
		<kwd-group kwd-group-type="author">
			<xsl:apply-templates/>
		</kwd-group>
	</xsl:template>
	<xsl:template match="h1[@class='jrnlKeywordHead']">
		<title>
			<xsl:apply-templates/>
		</title>
	</xsl:template>
	<xsl:template match="p[@class='jrnlKeywordPara']">
		<xsl:apply-templates/>
	</xsl:template>
	 <xsl:template match="span[@class='jrnlKeyword']">
		<kwd>
			<xsl:apply-templates/>
		</kwd> 
	</xsl:template> 
	<xsl:template match="p[@class='jrnlKeywordPara']/text()">
		<x>
			<xsl:value-of select="."/>
		</x>
	</xsl:template> -->
<!-- Keyword ENDS -->
	
	<!-- ===== ====== ==== -->
	<!-- FRONT MATTER ENDS -->
	<!-- ===== ====== ==== -->

	<!-- ==== ====== ====== -->
	<!-- BODY MATTER STARTS -->
	<!-- ==== ====== ====== -->
	<xsl:template match="div[@class='body']">
		<body>
			<xsl:apply-templates/>
		</body>
	</xsl:template>

	<xsl:template match="sec/h1[@class='jrnlHead1']">
		<title content-type="sec1">
			<xsl:apply-templates/>
		</title>
	</xsl:template>
<xsl:template match="sec/h2[@class='jrnlHead2']">
		<title content-type="sec2">
			<xsl:apply-templates/>
		</title>
	</xsl:template>
<xsl:template match="sec/h3[@class='jrnlHead3']">
		<title content-type="sec3">
			<xsl:apply-templates/>
		</title>
	</xsl:template>
<xsl:template match="sec/h4[@class='jrnlHead4']">
		<title content-type="sec4">
			<xsl:apply-templates/>
		</title>
	</xsl:template>
<xsl:template match="sec/h5[@class='jrnlHead5']">
		<title content-type="sec5">
			<xsl:apply-templates/>
		</title>
	</xsl:template>

	
	<xsl:template match="sec/h1[@class='jrnlAckHead']">
		<title content-type="secAck">
			<xsl:apply-templates/>
		</title>
	</xsl:template>
	<xsl:template match="p[@class='jrnlAckPara']">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

<!--		<xsl:template match="sec/h1[@class='jrnlHead1']|sec/h2[@class='jrnlHead2']|sec/h3[@class='jrnlHead3']|sec/h4[@class='jrnlHead4']|sec/h5[@class='jrnlHead5']|sec/h6[@class='jrnlHead6']|sec/h1[@class='jrnlAckHead']">
		<title>
			<xsl:apply-templates/>
		</title>
	</xsl:template>
-->
	
	<!-- remove empty -->
	<xsl:template match="*[normalize-space() = '']" />
	
	<xsl:template match="sec/p|p[@class='jrnlSecPara']">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="sec/p|p[@class='jrnlSecParaInd']">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	
	<xsl:template match="p[@class='jrnlEpiGraph']">
		<disp-quote><p>
			<xsl:apply-templates/>
		</p></disp-quote>
	</xsl:template>
	
	<!-- span class="newCommentNode" -->
	
	<xsl:template match="span[@class='newCommentNode']">
			<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="span[@class='commentNode']">
			<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="span[@title]">
			<xsl:apply-templates/>
	</xsl:template>
	
	<!-- ==== ====== ==== -->
	<!-- BODY MATTER ENDS -->
	<!-- ==== ====== ==== -->
	
	<!-- START Table Transformation -->
	<xsl:template match="p[@class='jrnlTblCaption']">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="span[@class='caption']">
		<caption>
			<p>
				<xsl:value-of select="parent::p/span[@class='label']" />
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
			</p>
		</caption>
	</xsl:template>
	<xsl:template match="span[@class='label']">
	</xsl:template>

	<!-- ADAPTED FROM http://stackoverflow.com/questions/4626873/html-to-cals-tables -->
	<xsl:template match="div[@class='jrnlTblBlock']">
		<table-wrap position="float" id="{./@id}">
			<xsl:if test="child::p[@class='jrnlTblCaption']">
				<xsl:attribute name="id">
					<xsl:value-of select="translate(@id, 'div_', '')"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates />
		</table-wrap>
	</xsl:template>
	<xsl:template match="table">
			<oasis:table xmlns:oasis="http://docs.oasis-open.org/ns/oasis-exchange/table" frame="topbot">
				<xsl:variable name="maxColumns">
					<xsl:for-each select="child::*/tr">
						<xsl:sort select="sum(td/@colspan) + count(td[not(@colspan)])" data-type="number"/>
						<xsl:if test="position() = last()">
							<xsl:value-of select="sum(td/@colspan) + count(td[not(@colspan)])"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<oasis:tgroup>
					<xsl:attribute name="cols">
						<xsl:value-of select="$maxColumns"/>
					</xsl:attribute>
					<xsl:call-template name="addColspec">
						<xsl:with-param name="max" select="number($maxColumns)"/>
					</xsl:call-template>
					<xsl:apply-templates select="node()"/>
				</oasis:tgroup>
			</oasis:table>
			<xsl:if test="name(following-sibling::*[1])='p' and following-sibling::*[1][@class='jrnlTblFoot']">
				<xsl:apply-templates select="following-sibling::p[@class='jrnlTblFoot'][1]" mode="tblFootMode" />
			</xsl:if>
	</xsl:template>
	<xsl:template match="thead">
		<oasis:thead>
			<xsl:apply-templates select="@*|node()"/>
		</oasis:thead>
	</xsl:template>
	<xsl:template match="tbody">
		<oasis:tbody>
			<xsl:apply-templates select="@*|node()"/>
		</oasis:tbody>
	</xsl:template>
	<xsl:template match="p[@class='jrnlTblFoot']" />
	<xsl:template match="p[@class='jrnlTblFoot']" mode="tblFootMode">
		<xsl:choose>
			<xsl:when test="count(preceding-sibling::p[@class='jrnlTblFoot']) = 0">
				<table-wrap-foot>
				<fn id="{./@id}">
						<p>
							<xsl:apply-templates select="node()"/>
						</p>
						</fn>
						<xsl:for-each select="following-sibling::p[@class='jrnlTblFoot']">
							<fn id="{./@id}"><p>
								<xsl:apply-templates select="node()"/>
							</p></fn>
						</xsl:for-each>
				</table-wrap-foot>
			</xsl:when>
			<xsl:otherwise>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ADAPTED FROM http://help.filemaker.com/app/answers/detail/a_id/5669/~/looping-in-xslt -->
	<xsl:template name="addColspec">
		<xsl:param name="i" select="number(1)"/>
		<xsl:param name="max"/>
		<xsl:if test="$i &lt;= $max">
			<!-- Repeated content Here -->
			<!-- use value-of i to get loop index -->
			<oasis:colspec align="left" colnum="{$i}" colname="col{$i}" colwidth="10*"/>
			<xsl:call-template name="addColspec">
				<xsl:with-param name="i" select="$i + 1"/>
				<xsl:with-param name="max" select="$max"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="th[@colspan &gt; 1]">
		<oasis:entry>
			<xsl:attribute name="namest">
				<xsl:text>col</xsl:text>
				<xsl:value-of select="sum(preceding-sibling::th/@colspan) + count(preceding-sibling::th[not(@colspan)]) + 1"/>
			</xsl:attribute>
			<xsl:attribute name="nameend">
				<xsl:text>col</xsl:text>
				<xsl:value-of select="sum(preceding-sibling::th/@colspan) + count(preceding-sibling::th[not(@colspan)]) + @colspan"/>
			</xsl:attribute>
			<xsl:if test="./@rowspan">
				<xsl:attribute name="morerows">
					<xsl:value-of select="./@rowspan - 1"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="child::p[@align]">
				<xsl:attribute name="align">
					<xsl:value-of select="child::p/@align"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*[name() != 'colspan']|node()"/>
		</oasis:entry>
	</xsl:template>
	
	<xsl:template match="td[@colspan &gt; 1]">
		<oasis:entry>
			<xsl:attribute name="namest">
				<xsl:text>col</xsl:text>
				<xsl:value-of select="sum(preceding-sibling::td/@colspan) + count(preceding-sibling::td[not(@colspan)]) + 1"/>
			</xsl:attribute>
			<xsl:attribute name="nameend">
				<xsl:text>col</xsl:text>
				<xsl:value-of select="sum(preceding-sibling::td/@colspan) + count(preceding-sibling::td[not(@colspan)]) + @colspan"/>
			</xsl:attribute>
			<xsl:if test="./@rowspan">
				<xsl:attribute name="morerows">
					<xsl:value-of select="./@rowspan - 1"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="child::p[@align]">
				<xsl:attribute name="align">
					<xsl:value-of select="child::p/@align"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*[name() != 'colspan']|node()"/>
		</oasis:entry>
	</xsl:template>
	

	<xsl:template match="tr">
		<oasis:row>
			<xsl:apply-templates/>
		</oasis:row>
	</xsl:template>

	<xsl:template match="td | th">
		<oasis:entry align="left">
			<xsl:if test="./@rowspan">
				<xsl:attribute name="morerows">
					<xsl:value-of select="./@rowspan - 1"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="child::p[@align]">
				<xsl:attribute name="align">
					<xsl:value-of select="child::p/@align"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</oasis:entry>
	</xsl:template>

	<xsl:template match="td/p | th/p">
		<xsl:apply-templates/>
		<xsl:if test="./following-sibling::p">
			<break/>
		</xsl:if>
	</xsl:template>
	<!-- END Table Transformation -->

	<!-- START Figure Transformation -->
	<xsl:template match="div[@class='jrnlFigBlock']">
			<fig id="{./@id}">
				<object-id pub-id-type="doi">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookDoi']"/><xsl:text>-</xsl:text>
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookArtID']"/><xsl:text>-</xsl:text>
					<xsl:value-of select="./@id"/>
				</object-id>
				<object-id pub-id-type="productid">
					<xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookPubID']"/>
				</object-id>
				<object-id pub-id-type="articleid"><xsl:value-of select="//table[@class='meta']/tbody/tr/td[@class='bookArtID']"/></object-id>
				<xsl:apply-templates />
			</fig>
	</xsl:template>

	<xsl:template match="div[@class='jrnlInlineFig']">
			<fig>
				<xsl:apply-templates />
			</fig>
	</xsl:template>

	
	
	
<xsl:template match="p[@class='jrnlFigCaption']/span[@class='caption'][2]">
<p>
	<xsl:apply-templates/>
</p>
</xsl:template>


	<xsl:template match="p[@class='jrnlFigCaption']">
			<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="p[@class='jrnlFigFoot']">
	<p>
			<xsl:apply-templates/>
	</p>
	</xsl:template>

	<xsl:template match="p[@class='jrnlFigCaption']/img">
		<graphic xlink:href="{./@alt}">
			<xsl:apply-templates/>
		</graphic>
	</xsl:template>

	
	
	<xsl:template match="span[@class='jrnlChemStruct']">
		<chem-struct-wrap content-type="unnumbered">
			<chem-struct>
				<xsl:apply-templates/>
			</chem-struct>
		</chem-struct-wrap>
	</xsl:template>

	<xsl:template match="span[@class='jrnlChemStruct']/img">
		<graphic xlink:href="{./@alt}">
			<xsl:apply-templates/>
		</graphic>
	</xsl:template>


	<!-- END Figure Transformation -->
	<xsl:template match="*[@class='jrnlDispFormula']">
                <disp-formula id="{@id}">
					<xsl:apply-templates/>
				</disp-formula>
	</xsl:template>

<xsl:template match="span[@class='jrnlInlineFormula']">
        <inline-formula id="{@id}">
					<xsl:apply-templates/>
        </inline-formula>
</xsl:template>

	<!-- <caption><p><inline-formula id="ILM0005">-->	
		
	
	<!-- ======= ========== ====== -->
	<!-- GENERAL FORMATTING STARTS -->
	<!-- ======= ========== ====== -->

	<xsl:template match="span[@class='jrnlBibRef']/sup">
			<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="span[@class='jrnlBibRef']">
		<xref ref-type="bibr" rid="{@rid}"><sup>
			<xsl:apply-templates/>
		</sup></xref>
	</xsl:template>
	

	
	<xsl:template match="span[@class='jrnlTblRef']">
		<xref ref-type="table" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	<xsl:template match="span[@class='jrnlFigRef']">
		<xref ref-type="fig" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	<xsl:template match="span[@class='jrnlBoxRef']">
		<xref ref-type="box" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	<xsl:template match="span[@class='jrnlSchRef']">
		<xref ref-type="scheme" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	
	
	<xsl:template match="span[@class='RefChemRef']">
		<xref ref-type="chem" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>

	<xsl:template match="span[@class='RefPrefix']">
		<prefix>
			<xsl:apply-templates/>
		</prefix>
	</xsl:template>
	<xsl:template match="span[@class='jrnlEqnRef']">
		<xref ref-type="disp-formula" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	<xsl:template match="span[@class='jrnlFnRef']">
		<xref ref-type="fn" rid="{@rid}">
			<xsl:apply-templates/>
		</xref>
	</xsl:template>
	

	<xsl:template match="span[@class='smallCaps']">
		<sc>
			<xsl:apply-templates/>
		</sc>
	</xsl:template>

	<xsl:template match="i|em">
		<italic>
			<xsl:apply-templates/>
		</italic>
	</xsl:template>
	<xsl:template match="span[@class='underLine']">
		<underline>
			<xsl:apply-templates/>
		</underline>
	</xsl:template>
	<xsl:template match="u|U|un|UN">
		<underline>
			<xsl:apply-templates/>
		</underline>
	</xsl:template>

	<xsl:template match="b|bold|strong">
		<bold>
			<xsl:apply-templates/>
		</bold>
	</xsl:template>
	<xsl:template match="a">
		<ext-link ext-link-type="uri">
			<xsl:apply-templates />
		</ext-link>
	</xsl:template>
	<!-- ======= ========== ==== -->
	<!-- GENERAL FORMATTING ENDS -->
	<!-- ======= ========== ==== -->

	<!-- ===== ====== -->
	<!-- LISTS STARTS -->
	<!-- ===== ====== -->
	<xsl:template match="ul|ol">
		<list>
			<xsl:attribute name="list-type">
				<xsl:value-of select="./@type" />
			</xsl:attribute>
			<xsl:apply-templates/>
		</list>
	</xsl:template>
	<xsl:template match="li/p">
		<list-item><p>
			<xsl:apply-templates/>
		</p></list-item>
	</xsl:template>

	<xsl:template match="li">
		<list-item><p>
			<xsl:apply-templates/>
		</p></list-item>
	</xsl:template>

	<!-- ===== ==== -->
	<!-- LISTS ENDS -->
	<!-- ===== ==== -->


	<!-- ==== ====== ====== -->
	<!-- BACK MATTER STARTS -->
	<!-- ==== ====== ====== -->
	<xsl:template match="div[@class='back']">
		<back>
			<xsl:apply-templates/>
		</back>
	</xsl:template>


	<!-- ========= ======== ====== -->
	<!-- REFERENCE ELEMENTS STARTS -->
	<!-- ========= ======== ====== -->
	<xsl:template match="h1[@class='jrnlRefHead']">
		<title>
			<xsl:apply-templates/>
		</title>
	</xsl:template>

	<xsl:template match="p[@class='jrnlRefText']">
		<ref id="{@id}">
			<element-citation>
				<xsl:attribute name="publication-type">
					<xsl:choose>
						<xsl:when test="./span[@class='RefConfName']">
							<xsl:text>confproc</xsl:text>
						</xsl:when>

					<xsl:when test="./span[@class='RefWebSite']">
							<xsl:text>web</xsl:text>
						</xsl:when>
	<!--				<xsl:when test="./span[@class='RefChapterTitle']">
							<xsl:text>book</xsl:text>
						</xsl:when>-->
					<xsl:when test="./span[@class='RefPatent']">
							<xsl:text>patent</xsl:text>
						</xsl:when>

					<xsl:when test="./span[@class='RefBookTitle']|./span[@class='RefChapterTitle']|./span[@class='RefPublisherName']|./span[@class='RefPublisherLoc']">
							<xsl:text>book</xsl:text>
						</xsl:when>

						<xsl:when test="./span[@class='RefJournalTitle']">
							<xsl:text>journal</xsl:text>
						</xsl:when>

						<xsl:otherwise>
							<xsl:text>journal</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:apply-templates/>
			</element-citation>
		</ref>
	</xsl:template>

	<xsl:template match="p[@class='jrnlRefText']/text()|person-group/text()">
	</xsl:template>

	<xsl:template match="span[@class='RefSlNo']" />

	<xsl:template match="span[@class='RefAuthor']|span[@class='RefEditor']">
		<string-name>
			<xsl:apply-templates/>
		</string-name>
	</xsl:template>
	<xsl:template match="span[@class='RefGivenNames']|span[@class='RefGivenName']">
		<given-names>
			<xsl:apply-templates/>
		</given-names>
	</xsl:template>
	<xsl:template match="span[@class='RefSurName']">
		<surname>
			<xsl:apply-templates/>
		</surname>
	</xsl:template>
	<xsl:template match="span[@class='RefSuffix']">
		<suffix>
			<xsl:apply-templates/>
		</suffix>
	</xsl:template>
	<xsl:template match="span[@class='RefArticleTitle']">
		<article-title>
			<xsl:apply-templates/>
		</article-title>
	</xsl:template>

	<xsl:template match="span[@class='RefISSN']">
		<issn>
			<xsl:apply-templates/>
		</issn>
	</xsl:template>


	<xsl:template match="span[@class='ConfName']">
		<source>
			<xsl:apply-templates/>
		</source>
	</xsl:template>


	<xsl:template match="RefPatant">
		<source>
			<xsl:apply-templates/>
		</source>
	</xsl:template>


	<xsl:template match="span[@class='RefIssn']">
		<issn>
			<xsl:apply-templates/>
		</issn>
	</xsl:template>

	<xsl:template match="span[@class='RefIssn']">
		<comment>
			<xsl:apply-templates/>
		</comment>
	</xsl:template>
	
	<xsl:template match="span[@class='RefChapterTitle']">
		<chapter-title>
			<xsl:apply-templates/>
		</chapter-title>
	</xsl:template>
	<xsl:template match="span[@class='RefJournalTitle']|span[@class='RefBookTitle']|span[@class='RefDiss']">
		<source>
			<xsl:apply-templates/>
		</source>
	</xsl:template>
	
	<xsl:template match="span[@class='RefDissUniv']">
		<publisher-loc>
			<xsl:apply-templates/>
		</publisher-loc>
	</xsl:template>
	<xsl:template match="span[@class='RefDissLoc']">
		<publisher-loc>
			<xsl:apply-templates/>
		</publisher-loc>
	</xsl:template>
	
	<xsl:template match="span[@class='RefPublisherLoc']">
		<publisher-loc>
			<xsl:apply-templates/>
		</publisher-loc>
	</xsl:template>
	<xsl:template match="span[@class='RefWebSite']">
		<ext-link>
			<xsl:apply-templates/>
		</ext-link>
	</xsl:template>
	
	

	<xsl:template match="span[@class='Doi']">
		<ext-link ext-link-type="doi">
			<xsl:apply-templates/>
		</ext-link>
	</xsl:template>
	
	<xsl:template match="span[@class='RefDOI']">
		<object-id>
			<xsl:apply-templates/>
		</object-id>
	</xsl:template>
	<xsl:template match="span[@class='RefISBN']">
		<isbn>
			<xsl:apply-templates/>
		</isbn>
	</xsl:template>
  
	<xsl:template match="span[@class='RefPublisherName']">
		<publisher-name>
			<xsl:apply-templates/>
		</publisher-name>
	</xsl:template>
	
<xsl:template match="span[@class='RefCollaboration']/span[@class='RefCollab']">
<collaboration>
			<xsl:apply-templates/>
</collaboration>
</xsl:template>
	
	
<xsl:template match="span[@class='RefCollab']">
		<collab>
			<xsl:apply-templates/>
		</collab>
	</xsl:template>
	<xsl:template match="span[@class='RefBookSeries']">
		<series>
			<xsl:apply-templates/>
		</series>
	</xsl:template>
	<xsl:template match="span[@class='RefPatent']">
		<patent>
			<xsl:apply-templates/>
		</patent>
	</xsl:template>
	<xsl:template match="span[@class='RefConfName']">
		<conf-name>
			<xsl:apply-templates/>
		</conf-name>
	</xsl:template>
	<xsl:template match="span[@class='RefConfLoc']">
		<conf-loc>
			<xsl:apply-templates/>
		</conf-loc>
	</xsl:template>
	<xsl:template match="span[@class='RefConfDate']">
		<conf-date>
			<xsl:apply-templates/>
		</conf-date>
	</xsl:template>
<xsl:template match="span[@class='RefConfTitle']">
		<source>
			<xsl:apply-templates/>
		</source>
	</xsl:template>
	<xsl:template match="span[@class='RefCollaboration']">
		<collaboration>
			<xsl:apply-templates/>
		</collaboration>
	</xsl:template>
	<xsl:template match="span[@class='RefDay']">
		<day>
			<xsl:apply-templates/>
		</day>
	</xsl:template>

	<xsl:template match="span[@class='RefConfSponsor']">
		<conf-sponsor>
			<xsl:apply-templates/>
		</conf-sponsor>
	</xsl:template>
	<xsl:template match="span[@class='RefVolume']">
		<volume>
			<xsl:apply-templates/>
		</volume>
	</xsl:template>
	<xsl:template match="span[@class='RefIssue']">
		<issue>
			<xsl:apply-templates/>
		</issue>
	</xsl:template>
	<xsl:template match="span[@class='RefPartTitle']">
		<part-title>
			<xsl:apply-templates/>
		</part-title>
	</xsl:template>
	<xsl:template match="span[@class='RefPageRange']">
		<page-range>
			<xsl:apply-templates/>
		</page-range>
	</xsl:template>


	<xsl:template match="span[@class='RefFPage']">
		<fpage>
			<xsl:apply-templates/>
		</fpage>
	</xsl:template>
	
	<xsl:template match="span[@class='Refetal']">
		<etal>
			<xsl:apply-templates/>
		</etal>
	</xsl:template>

	<xsl:template match="span[@class='RefEtal']">
		<etal>
			<xsl:apply-templates/>
		</etal>
	</xsl:template>
	
	<xsl:template match="span[@class='RefLPage']">
		<lpage>
			<xsl:apply-templates/>
		</lpage>
	</xsl:template>
	<xsl:template match="span[@class='RefPara']">
		<comment>
			<xsl:apply-templates/>
		</comment>
	</xsl:template>
	<xsl:template match="span[@class='RefElocId']">
		<elocation-id>
			<xsl:apply-templates/>
		</elocation-id>
	</xsl:template>
	<xsl:template match="span[@class='RefMonth']">
		<month>
			<xsl:apply-templates/>
		</month>
	</xsl:template>
	<xsl:template match="span[@class='RefDate']">
		<day>
			<xsl:apply-templates/>
		</day>
	</xsl:template>
	<xsl:template match="element-citation/date">
		<xsl:apply-templates />
	</xsl:template>
	<!-- suppress bold within year -->
	<xsl:template match="span[@class='RefYear']/b">
			<xsl:apply-templates/>
	</xsl:template>
	<!-- suppress italic within year -->

	<xsl:template match="span[@class='RefVolume']/i">
			<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="span[@class='RefYear']">
		<year content-type="copyright-year">
			<xsl:apply-templates/>
		</year>
	</xsl:template>
	<xsl:template match="span[@class='RefComments']">
	</xsl:template>
	<xsl:template match="span[@class='RefComment']">
	</xsl:template>
	<xsl:template match="span[@class='RefEdition']">
		<edition>
			<xsl:apply-templates />
		</edition>
	</xsl:template>
	<xsl:template match="span[@class='jrnlRefAnnot']">
		<note>
			<p>
				<xsl:apply-templates/>
			</p>
		</note>
	</xsl:template>

	<!-- ========= ======== ==== -->
	<!-- REFERENCE ELEMENTS ENDS -->
	<!-- ========= ======== ==== -->

	<!-- ==== ====== ==== -->
	<!-- BACK MATTER ENDS -->
	<!-- ==== ====== ==== -->
</xsl:stylesheet>
