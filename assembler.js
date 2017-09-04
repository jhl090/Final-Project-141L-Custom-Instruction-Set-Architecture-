/* CSE 141L Assembler
   Requires: NodeJS
   Purpose: Converts assembly code of ISA to binary code
   How-to: 
   	1. Copy assembly file into same folder as this file
   	2. Edit assemblyFile var in assembler.js to the name of assembly code
   	3. Run "node assembler.js"
	4. The output code is binary.txt

   Restrictions: 
	1. Branch targets must be one continuous "word":
	   Example: "1st_loop" is correct. "1st loop" is not correct

*/
var fs = require('fs');
var assemblyFile = "./ISA_unit_test.txt";
var binaryFile = "./binary.txt";
var instrCount = 0;
var branchList = []; //{name:   , destInstr: }

fs.readFile(assemblyFile, 'utf8', function(error, rawText){
	var rawLines = rawText.split("\n");
	var codedLines = []; // binary lines of instructions
	
	var codedInstr;		// 1 binary instruction
	var binaryCode;		// Full concatenated binary code


	for(var x = 0; x < rawLines.length; x ++){
		codedInstr = codeLine(rawLines[x], true);
	}
	//console.log("---- branch pass ------")


	instrCount = 0;
	for(var x = 0; x < rawLines.length; x ++){
		codedInstr = codeLine(rawLines[x], false);
		codedLines.push(codedInstr);
	}

	// Join all together
	binaryCode = codedLines.join("");
	//console.log({binaryCode});

	    console.log("branches ----")
	for(var x = 0; x < branchList.length; x++){
		console.log("Index: " + x + ", BranchName: " + branchList[x].name + ", destInstr: " + branchList[x].destInstr);
	}

	writeToFile(binaryCode);
});


function codeLine(rawLine, branchPass){
	var binaryInstr;	// Return Value
	var elements;    	//Seperated by spaces
	var operand;		
	var opCode; 		// Code Op Code and function bit
	var functCode = "";
	var onlySpaces;

	// Parsing
	rawLine = rawLine.replace("\r", "");    //Get rid of new Line
	rawLine = rawLine.replace("\t", " ");    //Get rid of tabs, replace with spaces
	rawLine = chop(rawLine);
	//console.log({rawLine});

	// ignore newLines
	if(rawLine == ""){ 	
		return "";
	}

	elements = rawLine.split(" ");
	
	// Ignore empty lines
	if(isEmpty(elements)){
		return "";
	} else if (isBranch(elements[0], branchPass)){  // what to do for branch names
		return "// " + elements[0].slice(0, -1) + "\r";
	}

	operand = codeOperand(elements[1]);
	opCode = codeOp(elements[0]);

	if(opCode.length == 5){   //If length is 5, means that there is opcode and function code
		functCode = opCode[opCode.length-1];
		opCode = opCode.slice(0, opCode.length-1);
	}

	// op code + operand + function code + "//[INSTR]"" + new line
	binaryInstr = opCode.concat(operand);
	binaryInstr = binaryInstr.concat(functCode);
	binaryInstr = binaryInstr.concat("   // " + instrCount + " " + rawLine + "\r");
	instrCount++;

	return binaryInstr;
}

function isBranch(element, branchPass){
	//Take off tabs
	element = element.replace('\t', '');

	var obj = {};
	if(element[element.length-1] == ':'){
		obj.name = element.slice(0, element.length-1);
		obj.destInstr = instrCount;
		if(branchPass){
			branchList.push(obj);
		}
		return true;
	} else {
		return false;
	}
}

//Chops off beginning white space and comments
function chop(line){
	for(var x = 0; x<line.length; x++){
		if(line[x] != " " && line[x] != '' && line[x] != '\t'){
			line = line.slice(x, line.length);
			break;
		}
	}

	var commentIndex = line.indexOf("//");    //Get rid of comments
	if(commentIndex != -1){
		line = line.slice(0, commentIndex);
	}

	return line;
}

function isEmpty(lineElements){
	var empty = true;
	for(var i = 0; i < lineElements.length; i++){
		if(lineElements[i] != ''){
			for(var x = 0; x<lineElements[i].length; x++){
				if(lineElements[i][x] != '' && lineElements[i][x] != "\t"){
					empty = false;
					break;
				}
			}
		}

	}
	return empty;
}

// The function code is least significant bit
function codeOp(op){
	switch(op){
		case "ld":
			return "10000";
		case "st":
			return "10001";
		case "mar":
			return "10010";
		case "mra":
			return "10011";
		case "addrc":
			return "10100";
		case "fl":
			return "10101";
		case "inc":
			return "10110";
		case "dec":
			return "10111";
		case "addi":
			return "0000";
		case "addr":
			return "11000";
		case "bne":
			return "0001";
		case "blt":
			return "0010";
		case "slti":
			return "0011";
		case "sltr":
			return "11001";
		case "slli":
			return "0100";
		case "sllo":
			return "0101";
		case "sra":
			return "11010";
		case "sro":
			return "11011";
		case "srl":
			return "11100";
		case "strc":
			return "11101";
		case "j":
			return "0110";
		case "and":
			return "0111";
		case "sus":
			return "11111";
		case "sub":
			return "11110";
		default:
			return "erro";
			break;
	}

	return;
}

function codeOperand(operand){
	var op = '';
	for(var x = 0; x<operand.length; x++){
		if(operand[x] != '\t'){
			op = op.concat(operand[x]);
		}
	}
	console.log({op});
	switch(op){
		case "$zero":
			return "0000";
		case "$mem":
			return "0001";
		case "$acc":
			return "0010";
		case "$t0":
			return "0011";
		case "$t1":
			return "0100";
		case "$t2":
			return "0101";
		case "$t3":
			return "0110";
		case "$t4":
			return "0111";
		case "$t5":
			return "1000";
		case "$t6":
			return "1001";
		case "$t7":
			return "1010";
		case "$t8":
			return "1011";
		case "$t9":
			return "1100";
		case "$t10":
			return "1101";
		case "$t11":
			return "1110";
		case "$t12":
			return "1111";
		default:
			var signed = parseInt(operand, 10);
			var isBranchIndex = false;

			// If branchname, replace with index
			for(var x = 0; x<branchList.length; x++){
				if(branchList[x].name == op){
					signed = x;
					//console.log({operand, signed});
					isBranchIndex = true;
					break;
				}
			}

			if(isNaN(signed)){
				return "1111";
			}
			if(!isBranchIndex){
				if(signed < -16 || signed > 15){
					console.error("ERROR: SIGNED < -16 or SIGNED > 15!")
					return "erro";
				}
			}

			if(signed < 0){
				signed = (signed >>> 0).toString(2);
				signed = signed.slice(signed.length - 5, signed.length);
				//console.log(signed);
			} else {
				signed = (signed >>> 0).toString(2);
				//console.log(signed);
			}
			while(signed.length < 5){
				signed = "0".concat(signed);
			}
			//console.log({operand, signed});
			return signed;
	}
}

function writeToFile(codedInstr){
	fs.writeFile(binaryFile, codedInstr, function(err) {
	    if(err) {
	        return console.log(err);
	    }

	    console.log("The file was saved!");
	}); 
}