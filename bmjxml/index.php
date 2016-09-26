<?php

## read the file from the given path
ini_set('display_errors', 'off');
header('Content-Type: text/html; charset=utf-8');
require_once 'lib/JSLikeHTMLElement.php';
$inputPath = 'D:\Webserver\bmj_sgm2xml\input';
$rawSGMPath = 'D:\Webserver\bmj_sgm2xml\processed\raw_sgm';
$rawXMLPath = 'D:\Webserver\bmj_sgm2xml\processed\raw_xml';
$fileName = '20010301.0';




$fullFileName = "{$inputPath}\\{$fileName}";

$opts = array(
		'http'=>array(
				'method'=>"POST",
				'header'=>"Accept-language: en\r\n" .
				"Cookie: foo=bar\r\n" .
				"Content-Type: text/html; charset=UTF-8"
		)
);
$context = stream_context_create($opts);


$urlContent = file_get_contents($fullFileName, false, $context);
$urlContent = mb_convert_encoding($urlContent, 'HTML-ENTITIES',"UTF-8");

$doc = new DOMDocument('1.0', 'UTF-8');
$doc->formatOutput = false;
$doc->registerNodeClass('DOMElement', 'JSLikeHTMLElement');
$doc->loadHTML($urlContent);
#$doc->html_entity_decode($doc);
$xpath = new DOMXPath($doc);

$dNodes = $xpath->query('//d');
echo 'dNodes Length:' . $dNodes->length;
	
## load the xsl into dom for transformation
$xsl = new DOMDocument();
$xsl->formatOutput = false;
$xsl->load("D:\Webserver\bmj_sgm2xml\processed\xsl\OVID_2_JATS.xsl");
$proc = new XSLTProcessor();
$xsl = $proc->importStylesheet($xsl);

foreach ($dNodes as $dNode){
	$sgmFileName = $rawSGMPath . "\\" . $dNode->getAttribute('file') . '.sgm';
	file_put_contents($sgmFileName, mb_convert_encoding($doc->saveXML($dNode), 'HTML-ENTITIES',"UTF-8"));
	//file_put_contents($sgmFileName, $doc->saveXML($dNode));
	
	## load the sgm into dom
	$sgmDoc = new DOMDocument('1.0', 'UTF-8');
	$sgmDoc->formatOutput = true;
	$sgmDoc->loadHTMLFile($sgmFileName);
	
	$newdom = $proc->transformToDOC($sgmDoc);
	$processedData = mb_convert_encoding($newdom->saveXML(), 'HTML-ENTITIES', "UTF-8");
	$xmlFileName = $rawXMLPath . "\\" . $dNode->getAttribute('file') . '.xml'; 
	$processedData = preg_replace('/\&amp\;([a-z])/', '&$1', $processedData);
	$processedData = preg_replace('/\<title\>\<e [^>]*\>(.*)\<\/e\>\<\/title\>/', '<title>$1</title>', $processedData);
	$processedData = preg_replace('/\<title\>\<bold\>\<italic\>/', '<title>', $processedData);
	$processedData = preg_replace('/\<\/italic\>\<\/bold\>\<\/title\>/', '</title>', $processedData);
	$processedData = preg_replace('/\<sec\>\<p\>/', '<sec><title/><p>', $processedData);
	$processedData = preg_replace('/\<sec\>\<title\>(METHODS|Methods)\<\/title\>/', '<sec sec-type="methods"><title>$1</title>', $processedData);
	$processedData = preg_replace('/\<xref ref-type="aff" rid="AF([0-9]),([0-9])"\/\>/', '<xref ref-type="aff" rid="AF$1"/><xref ref-type="aff" rid="AF$2"/>', $processedData);
	$processedData = preg_replace('/\&hyphen\;/', '-', $processedData);
	$processedData = preg_replace('/\&commat\;/', '@', $processedData);
	$processedData = preg_replace('/\&colon\;/', ':', $processedData);
	$processedData = preg_replace('/\&amp\;Dgr\;/', '&Dgr;', $processedData);
	$processedData = preg_replace('/\<contrib\-group\>\<contrib contrib\-type="author"\><name><surname>\&amp\;NA\;<\/surname>\<given\-names\/\>(.*)\<\/contrib-group\>/', '', $processedData);
	$processedData = preg_replace('/\<sec\>(\<title\>ACKNOWLEDGMENTS\<\/title\>(.*))\<\/sec\>/', '<ack>$1</ack>', $processedData);
	$processedData = preg_replace('/\<sec\>(<fig[^>]*>(.*)<\/fig>)(.*)<\/p>/', '<sec><title/>$3</p>$1', $processedData);
	$processedData = preg_replace('/\<page\>([0-9]+)\<\/page\>/', '<fpage>$1</fpage><lpage>$1</lpage>', $processedData);
	$processedData = preg_replace('/(\<p\>|\<\/p\>|\<aff[^>]*\>)\n/', '$1', $processedData);
	$processedData = preg_replace('/(\<ack\>)(.*)(\<\/body\>\<back\>)/', '$3$1$2', $processedData);
	$processedData = preg_replace('/\<\/front\>\<abstract\>(.*)<\/abstract>/', '</front>', $processedData);
	$processedData = preg_replace('/\<aff[^>]*\>(\<sup\>([0-9]+)\<\/sup\>)?\<italic\>(.*)\<\/italic\>\<\/aff\>/', '<aff>$1$3</aff>', $processedData);
	$processedData = preg_replace('/\<bold\>\<italic\>Figure ([0-9]+)(\.)?\<\/italic\>\<\/bold\>/', 'Figure $1$2 ', $processedData);
	$processedData = preg_replace('/\<label\/\>(\<caption>\<p\>)Table ([0-9]) /', '<label>Table $2</label>$1', $processedData);
	$processedData = preg_replace('/\<p\>\<italic\>(.*)\<\/italic\>\<\/p\>/', '<p>$1</p>', $processedData);
	$processedData = preg_replace('/\<subtitle\/\>/', '', $processedData);
	$processedData = preg_replace('/\<page\>([0-9]+)\&ndash\;([0-9]+)\<\/page\>/', '<fpage>$1</fpage><lpage>$2</lpage>', $processedData);
	$processedData = preg_replace('/ xlink:href="G/', ' xlink:href="', $processedData);
	$processedData = preg_replace('/\<abstract\>\<sec\>/', '<abstract>', $processedData);
	$processedData = preg_replace('/\<\/sec\>\<\/abstract\>/', '</abstract>', $processedData);
	
	$processedData = preg_replace('/\<aff\>/', '<aff id="AF1">', $processedData);

	//<fig id="F1-1"><caption>Figure 1 <italic>Model for genesis and clinical relevance of autoantibodies reactive to</italic></caption>
	$processedData = preg_replace('/(\<caption\>)Figure ([0-9]) \<italic\>(.*)\<\/italic\>/', '<label>Figure $2</label>$1<p>$3</p>', $processedData);
	
	$processedData = preg_replace('/ \<email\/\>/', '', $processedData);
	$processedData = preg_replace('/:(\<\/title\>)/', '$1', $processedData);
	
	
	
	file_put_contents($xmlFileName, $processedData);
}

?>