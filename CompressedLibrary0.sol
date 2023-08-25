
pragma solidity ^0.8.20;

contract CompressedLibrary0 {
    string public data;

    constructor() {
        data = "!function(e,t){\"object\"==typeof exports&&\"object\"==typeof module?module.exports=t():\"function\"==typeof define&&define.amd?define([],t):\"object\"==typeof exports?exports.zen=t():e.zen=t()}(this,(()=>(()=>{\"use strict\";var e,t={d:(e,n)=>{for(var s in n)t.o(n,s)&&!t.o(e,s)&&Object.defineProperty(e,s,{enumerable:!0,get:n[s]})},o:(e,t)=>Object.prototype.hasOwnProperty.call(e,t),r:e=>{\"undefined\"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:\"Module\"}),Object.defineProperty(e,\"__esModule\",{value:!0})}},n={};t.r(n),t.d(n,{Component:()=>$t,Context:()=>oe,LoopContext:()=>le,abs:()=>C,accum:()=>accum,add:()=>d,and:()=>w,argument:()=>ne,atan:()=>L,biquad:()=>_e,biquadI:()=>Ee,breakIf:()=>Ae,cKeywords:()=>u,call:()=>X,ceil:()=>I,change:()=>Pe,clamp:()=>Z,clearData:()=>ke,click:()=>Me,compressor:()=>Te,cos:()=>V,createWorklet:()=>Be,cycle:()=>cycle,data:()=>Ve,dcblock:()=>wt,decay:()=>bt,decayTrig:()=>yt,defun:()=>J,delay:()=>Ne,delta:()=>je,div:()=>y,elapsed:()=>Mt,emitArguments:()=>te,emitCode:()=>ue,emitFunctions:()=>ee,emitHistory:()=>ie,emitOuterHistory:()=>ae,emitOuterLoops:()=>de,emitParams:()=>re,eq:()=>K,exp:()=>N,exp2:()=>G,fixnan:()=>Kt,float:()=>$e,floor:()=>S,func:()=>m,genArg:()=>ye,generateStructure:()=>ht,gt:()=>v,gte:()=>x,history:()=>se,initMemory:()=>Ye,input:()=>he,latch:()=>De,log:()=>O,log10:()=>j,log2:()=>k,lt:()=>f,lte:()=>g,max:()=>F,message:()=>at,min:()=>R,mix:()=>q,mod:()=>E,mstosamps:()=>xt,mult:()=>b,neq:()=>_,noise:()=>ut,not_sub:()=>Q,nth:()=>Y,onepole:()=>Ce,op:()=>l,or:()=>M,output:()=>ge,param:()=>pt,peek:()=>ze,phasor:()=>we,poke:()=>Oe,pow:()=>P,print:()=>fe,rampToTrig:()=>Le,rawSumLoop:()=>st,reciprical:()=>H,round:()=>U,s:()=>dt,sampstoms:()=>vt,scale:()=>mt,selector:()=>Ke,shiftLeft:()=>$,shiftRight:()=>h,sign:()=>B,sin:()=>A,sine:()=>gt,sqrt:()=>D,sub:()=>p,sumLoop:()=>nt,svf:()=>Ie,t60:()=>ct,tan:()=>T,tanh:()=>z,triangle:()=>ft,vactrol:()=>Se,variable:()=>it,wrap:()=>W,xor:()=>c,zen:()=>ce,zenC:()=>be,zswitch:()=>rt,zswitch_inline_else:()=>lt,zswitch_inline_then:()=>ot});class s{}class i extends s{constructor(e,t,n,s,i){super(),this.context=e,this.__idx=-1,this._size=n,this.idx=t,this.size=n,this.allocatedSize=s,this.initData=i}set idx(e){this.__idx=e}get idx(){return this.__idx}set size(e){this._size=e}get size(){return this._size}respond(e){this.responseCallback(e),this.waitingForResponse=void 0}get(){return this.context.postMessage({type:\"memory-get\",body:{idx:this.idx,allocatedSize:this.allocatedSize}}),this.waitingForResponse=\"memory-get\",new Promise((e=>{this.responseCallback=e}))}}class a extends i{constructor(e,t,n,s){super(e,t,n,s),this.context=e,this._idx=t,this._size=n,this.allocatedSize=s,this.channels=0,this.length=0}get idx(){return`${this._idx} + ${this.allocatedSize}*${this.context.loopIdx}`}set idx(e){this._idx=e}get size(){return this._size*this.context.loopSize}set size(e){this._size=e}}class r{constructor(e,t){this.size=t,this.context=e,this.references=0,this.blocksInUse=[],this.freeList=[new i(e,0,t,0)]}alloc(e){for(let t=0;t<this.freeList.length;t++){let n=this.freeList[t];if(e<=n.size)return n=this.useBlock(n,e,t),n.allocatedSize=e,this.blocksInUse.push(n),n}return this.increaseHeapSize(),this.alloc(e)}increaseHeapSize(){this.size*=2;let e=this.freeList[this.freeList.length-1];e.size=this.size-e.allocatedSize}useBlock(e,t,n){return e.size==t?this.freeList.splice(n,1):this.freeList.splice(n,1,new i(this.context,e.idx+t,e.size-t,t)),this.references++,e}free(e){this.freeList.push(e),this.references--,0===this.references&&(this.freeList[0].idx=0)}}!function(e){e[e.Javascript=0]=\"Javascript\",e[e.C=1]=\"C\"}(e||(e={}));const o=e=>{let t,n;return s=>{if(void 0!==t){if(n===s)return s.isVariableEmitted(t.variable)?Object.assign(Object.assign({},t),{code:t.variable}):t;if(n.context&&s.isVariableEmitted(t.variable)){let e=Object.assign(Object.assign({},t),{code:t.variable});n=s;let i=!1;if(t.variables){for(let e of t.variables)if(s.isVariableEmitted(e)){i=!0;break}if(!i)for(let e of t.variables)s.emittedVariables[e]=!0}return i?e:t}if(!t.variable.includes(\"click\")){if(s.isVariableEmitted(t.variable))return Object.assign(Object.assign({},t),{code:t.variable});let e=!1;if(t.variables)for(let n of t.variables)if(s.isVariableEmitted(n)){e=!0;break}if(!e){if(t.variables)for(let e of t.variables)s.emittedVariables[e]=!0;return s.emittedVariables[t.variable]=!0,t}}}return n=s,t=e(s),t}},l=(t,n,s,i)=>(...a)=>o((r=>{let o=a.map((e=>r.gen(e))),[l]=r.useVariables(n+\"Val\"),u=`${r.varKeyword} ${l} = ${o.map((e=>e.variable)).join(\" \"+t+\" \")};`;if(\"%\"===t&&r.target===e.C&&(u=`${r.varKeyword} ${l} = fmod(${o[0].variable}, ${o[1].variable});`),\"^\"===t&&r.target===e.C&&(u=`${r.varKeyword} ${l} = ((int)${o[0].variable})^((int) ${o[1].variable});`),\"/\"===t&&(u=`${r.varKeyword} ${l} = ${o[1].variable} == 0.0 ? 0.0 : ${o.map((e=>e.variable)).join(\" \"+t+\" \")};`),a.every((e=>\"number\"==typeof e))&&void 0!==s){let e=a.map((e=>e)).reduce(s,void 0===i?a[0]:i);return u=`${r.varKeyword} ${l} = ${e};`,r.emit(u,l)}return r.emit(u,l,...o)})),u={\"Math.abs\":\"fabs\",\"Math.random\":\"random_double\",\"Math.floor\":\"floor\",\"Math.round\":\"round\",\"Math.ceil\":\"ceil\",\"Math.sin\":\"sin\",\"Math.tan\":\"tan\",\"Math.cos\":\"cos\",\"Math.tanh\":\"tanh\",\"Math.log2\":\"(1.0f / log(2)) * log\",\"Math.log10\":\"log10\",\"Math.pow\":\"pow\",\"Math.atan\":\"atan\",\"Math.exp\":\"exp\",\"Math.sqrt\":\"sqrt\",\"Math.min\":\"fmin\",\"Math.max\":\"fmax\"},m=(t,n,s)=>(...i)=>a=>{let r=i.map((e=>a.gen(e))),[o]=a.useVariables(`${n}Val`),l=a.target===e.C?u[t]:t,m=i.length>0&&i.every((e=>\"number\"==typeof e))?`${a.varKeyword} ${o} = ${s(...i)};`:`${a.varKeyword} ${o} = ${l}(${r.map((e=>e.variable)).join(\",\")});`;return a.emit(m,o,...r)},d=l(\"+\",\"add\",((e,t)=>e+t),0),$=l(\"<<\",\"shiftLeft\",((e,t)=>e<<t),0),h=l(\">>\",\"shiftRight\",((e,t)=>e>>t),0),p=l(\"-\",\"sub\",((e,t)=>e-t)),c=l(\"^\",\"xor\",((e,t)=>e^t)),b=l(\"*\",\"mult\",((e,t)=>e*t),1),y=l(\"/\",\"div\",((e,t)=>e/t)),f=l(\"<\",\"lt\"),g=l(\"<=\",\"lte\"),v=l(\">\",\"gt\"),x=l(\">=\",\"gte\"),w=l(\"&&\",\"and\"),M=l(\"||\",\"or\"),K=l(\"==\",\"eq\"),_=l(\"!=\",\"neq\"),E=l(\"%\",\"mod\",((e,t)=>e%t)),C=m(\"Math.abs\",\"abs\",Math.abs),S=m(\"Math.floor\",\"floor\",Math.floor),I=m(\"Math.ceil\",\"ceil\",Math.ceil),A=m(\"Math.sin\",\"sin\",Math.sin),T=m(\"Math.tan\",\"tan\",Math.tan),V=m(\"Math.cos\",\"cos\",Math.cos),z=m(\"Math.tanh\",\"tanh\",Math.tanh),O=m(\"Math.log\",\"log\",Math.log),k=m(\"Math.log2\",\"log2\",Math.log2),j=m(\"Math.log10\",\"log10\",Math.log10),P=m(\"Math.pow\",\"pow\",Math.pow),L=m(\"Math.atan\",\"atan\",Math.atan),N=m(\"Math.exp\",\"exp\",Math.exp),D=m(\"Math.sqrt\",\"sqrt\",Math.sqrt),R=m(\"Math.min\",\"min\",Math.min),F=m(\"Math.max\",\"max\",Math.max),B=e=>p(f(0,e),f(e,0)),q=(e,t,n)=>d(b(t,n),b(e,p($e(1),n))),W=(t,n,s)=>o((i=>{let a=i.gen(t),r=i.gen(n),o=i.gen(s),l=`(${o.variable} - ${r.variable})`,[m,d,$]=i.useVariables(\"wrapVal\",\"diffVal\",\"normalized\");i.target,e.C,r.variable,i.target===e.C&&u[\"Math.floor\"];let h=`\\n${i.varKeyword} ${d} = ${l};\\n${i.varKeyword} ${$} = ${p=a.variable+\" - \"+r.variable,c=d,i.target===e.C?`fmod(${p}, ${c})`:`((${p})%(${c}))`};\\n${i.varKeyword} ${m} = ${$} >= 0 ? ${$} + ${r.variable} : ${d} + ${$} + ${r.variable};\\n`;var p,c;return i.emit(h,m,a,r,o)})),Z=(e,t,n)=>o((s=>{let i=s.gen(e),a=s.gen(t),r=s.gen(n),[o]=s.useVariables(\"clampVal\"),l=`\\n${s.varKeyword} ${o} = ${i.variable};\\nif( ${o} < ${a.variable}) ${o} = ${a.variable};\\nelse if(${o} > ${r.variable}) ${o} = ${r.variable};`;return s.emit(l,o,i,a,r)})),H=e=>o((t=>{let n=t.gen(e),[s]=t.useVariables(\"recipricalValue\"),i=`${t.varKeyword} ${s} = ${n.variable} == 0 ? 0 : 1.0/${n.variable};`;return t.emit(i,s,n)})),Q=(e,t)=>o((n=>{let s=n.gen(e),i=t?n.gen(t):$e(1)(n),[a]=n.useVariables(\"notSubValue\"),r=`${n.varKeyword} ${a} = ${i.variable} - ${s.variable};`;return n.emit(r,a,s)})),U=(t,n,s)=>o((i=>{let a=i.gen(t),r=i.gen(n),[o,l]=i.useVariables(\"roundVal\",\"div\"),m=`\\n${i.varKeyword} ${l} = ${a.variable} / ${r.variable};\\n`,d=\"\";switch(s){case\"ceil\":d=i.target===e.C?u[\"Math.ceil\"]:\"Math.ceil\";break;case\"trunc\":d=\"Math.trunc\";break;case\"floor\":d=i.target===e.C?u[\"Math.floor\"]:\"Math.floor\";break;case\"nearest\":d=i.target===e.C?u[\"Math.round\"]:\"Math.round\"}return m+=`\\n${i.varKeyword} ${o} = ${r.variable} * ${d}(${l});\\n`,i.emit(m,o,a,r)})),G=e=>P(2,e),J=(t,n,...s)=>{let i;return a=>{if(i)return i;let r=a.functions.find((e=>e.name===t));if(r)return r;let o=new le(\"invocation\",{min:0,max:n},a),l=s.map((e=>e(o))),u=Array.from(new Set(l.flatMap((e=>e.histories)).filter((e=>e)))),m=Array.from(new Set(l.flatMap((e=>e.outerHistories||[])))),d=`${a.target===e.C?\"\":\"this.\"}${t}Array`,$=\"\",h=0,p={};for(let e of l){p=Object.assign({},e);let t=e.code;t.includes(\";\")||(t+=\";\"),$+=`\\n${t}\\n${d}[${h}] = ${e.variable};\\n            `,h++}let c=a.target===e.C?\"&\":\"\";return i=Object.assign(Object.assign({},p),{name:t,variables:[],size:n,code:$,variable:c+d,params:[],functions:ee(...l),functionArguments:te(...l),histories:[...u,...m]}),a.functions.push(i),i}},X=(t,n,...s)=>{let i=!1;return o((a=>{let r=t(a),o=s.map((e=>a.gen(e))),l=r.name;i=!0;let[u]=a.useVariables(`${l}Value`),m=a.target===e.Javascript?\"this.\":\"\",d=`${a.target===e.C?a.varKeyword+\"*\":\"let\"} ${u} = ${m}${l} (${n}, ${o.map((e=>e.variable)).join(\",\")}); \\n`;for(let e=0;e<8;e++)d+=`${a.varKeyword} ${u}_${e} = ${u}[${e}];\\n`;let $=a.emit(d,u,...o),h=$.functions||[];return $.functions=[...h,r],$}))},Y=(t,n=0)=>o((s=>{let i=s.gen(t),a=s.gen(n),[r]=s.useVariables(\"nth\"),o=(s.target,e.C,s.target===e.C&&u[\"Math.floor\"],`${s.varKeyword} ${r} = ${i.variable}_${parseInt(a.variable)};`);return s.emit(o,r,i,a)})),ee=(...e)=>Array.from(new Set(e.flatMap((e=>e.functions||[])))),te=(...e)=>Array.from(new Set(e.flatMap((e=>e.functionArguments)))).filter((e=>e)),ne=(e,t)=>o((n=>{let[s]=n.useVariables(\"funcArg\"),i=`${n.context?n.context.varKeyword:n.varKeyword} ${s} = ${t}; `,a=n.emit(i,s);a.isLoopDependent=!0;let r=[...a.functionArguments,{name:t,num:e}];return r=Array.from(new Set(r)),a.functionArguments=r,a})),se=(e,t,n)=>{let s,i,a,r,o=[],l=(u,m)=>d=>{let $=d;if(t&&t.name)for(;\"context\"in $;)$=$.context;d=$;let h=\"number\"==typeof u?$e(u)($):u?u($):void 0,p=void 0===m?$.gen($e(0)):$.gen(m),c=a!==d;a=d,(void 0===s||c)&&(s=a.alloc(1),i=a.useVariables(n||\"historyVal\")[0],o=o.filter((e=>!e.context.disposed)),o.push({context:a,block:s})),44794===s._idx&&console.log(\"BLOCK IDX context=\",a,s);let b=s.idx,y=`${a.varKeyword} ${i} = memory[${b}]\\n`,f=\"\",g=i;if(h){let[e]=a.useVariables(\"histVal\");f=`\\n// history insert\\nmemory[${b}] = ${h.variable};\\n`,t&&t.inline||(f+=`${a.varKeyword} ${e} = ${i};\\n`),t&&t.inline&&(e=f,f=\"\"),g=e,f=\"/* begin history emit */ \"+f+\" /* end history emit */\",f=ue(a,f,g,h,p)}let v=h?ie(h,p):[],x=h?ae(h,p):[],w=h?ee(h,p):[],M=h?te(h,p):[];void 0!==e&&(s.initData=new Float32Array([e])),void 0!==r&&(s.initData=new Float32Array([r]));let K=h?re(h):[];return t&&t.name&&(K=[l,...K]),y.includes(\"*\")||(x=[y,...x]),{code:f,variable:g,histories:[y,...v],outerHistories:x,params:K,functions:w,variables:[g],functionArguments:M}};return t&&(l.paramName=t.name),l.value=(e,t)=>{if(void 0!==a){for(let{context:n,block:s}of o){let i=void 0!==t?\"schedule-set\":\"memory-set\",a={idx:s.idx,value:e,time:t};n.postMessage({type:i,body:a})}r=e}},l},ie=(...e)=>Array.from(new Set(e.flatMap((e=>e.histories)))),ae=(...e)=>Array.from(new Set(e.flatMap((e=>e.outerHistories||[])))),re=(...e)=>Array.from(new Set(e.flatMap((e=>e.params))));class oe{constructor(t=e.Javascript){this.memory=new r(this,4194304),this.idx=0,this.histories=0,this.functions=[],this.historiesEmitted=[],this.numberOfInputs=1,this.sampleRate=44100,this.emittedVariables={},this.worklets=[],this.disposed=!1,this.target=t}get varKeyword(){return this.target===e.C?\"double\":\"let\"}get intKeyword(){return this.target===e.C?\"int\":\"let\"}alloc(e){return this.memory.alloc(e)}addWorklet(e){this.worklets.push(e)}postMessage(e){this.worklets.forEach((t=>t.port.postMessage(e)))}onMessage(e){for(let t of this.memory.blocksInUse)t.waitingForResponse===e.type&&t.respond(e.body)}isVariableEmitted(e){return!0===this.emittedVariables[e]}useVariables(...e){let t=this.idx++;return e.map((e=>`${e}${t}`))}gen(e){return void 0===e&&(e=0),\"number\"==typeof e?$e(e)(this):\"function\"==typeof e?e(this):$e(0)(this)}emit(e,t,...n){let s=ie(...n),i=ee(...n),a=te(...n),r=ae(...n),o=Array.from(new Set([...r,...s.filter((e=>!e.includes(\"*\")&&!e.includes(\"loopIdx\")))])),l=n.some((e=>e.isLoopDependent));\"context\"in this&&(s=s.filter((e=>e.includes(\"*\"))));let u=re(...n),m=[t];for(let{variables:e}of n)e&&(m=[...m,...e]);let d={code:ue(this,e,t,...n),variable:t,histories:s,outerHistories:o,params:u,variables:m,context:this,functions:i,functionArguments:a,isLoopDependent:l},$=n.filter((e=>void 0!==e.inputs)).map((e=>e.inputs));return $.length>0&&(d.inputs=Math.max(...$)),d}input(e){return e>this.numberOfInputs&&(this.numberOfInputs=e),\"in\"+e}}class le extends oe{constructor(e,t,n){super(),this.context=n,this.loopIdx=e,this.loopSize=t.max-t.min,this.memory=n.memory,this.idx=n.idx,this.histories=n.histories,this.numberOfInputs=n.numberOfInputs,this.sampleRate=n.sampleRate,this.emittedVariables=Object.assign({},n.emittedVariables),this.worklets=n.worklets,this.target=n.target}useVariables(...e){return this.context.useVariables(...e)}isVariableEmitted(e){return!0===this.emittedVariables[e]||this.context.isVariableEmitted(e)}alloc(e){let t=this.memory.alloc(e*this.loopSize),n=this.memory.blocksInUse.indexOf(t),s=(this.context,new a(this,t.idx,t.size,e));return this.memory.blocksInUse[n]=s,s}}const ue=(e,t,n,...s)=>{let i=\"\";if((t.trim().startsWith(\"let\")||t.trim().startsWith(\"double\"))&&e.isVariableEmitted(n))return n;\"peekVal271\"===n&&console.log(\"setting emitted variables[%s] = true\",n,e),e.emittedVariables[n]=!0;for(let t of s)me(t)&&(i+=t.code,\"peekVal271\"===t.variable&&console.log(\"loop setting emitted variables[%s] = true\",t.variable,e),e.emittedVariables[t.variable]=!0);return\"peekVal271\"===n&&console.log(\"return vout=\",i+\"\\n\"+t),i+\"\\n\"+t},me=e=>e.code!==e.variable,de=(...e)=>Array.from(new Set(e.flatMap((e=>e.outerLoops||[])))),$e=e=>{let t=e.toString();return e-Math.floor(e)==0&&(t+=\".0\"),()=>({code:t,variable:t,variables:[],functions:[],functionArguments:[],histories:[],params:[]})},he=(e=0)=>t=>{let n=t.input(e);return{code:n,functions:[],functionArguments:[],variable:n,variables:[],histories:[],inputs:e,params:[]}},pe=(e,...t)=>{let n=new oe(e),s=\"\",i=\"\",a=1,r=1,o=[],l=[],u=[],m=[];for(let e of t){let t=e(n);s+=\" \"+t.code,i=t.variable,l=[...l,...t.params],t.variables&&(m=[...m,...t.variables]),t.histories&&(o=[...o,...t.histories]),t.functions&&(u=[...u,...t.functions],u=Array.from(new Set(u))),void 0!==t.outputs&&t.outputs+1>a&&(a=t.outputs+1),void 0!==t.inputs&&t.inputs>r&&(r=t.inputs)}return 1===a&&(s+=`\\noutput0 = ${i};\\n`),{code:s,context:n,variable:i,variables:m,histories:o,numberOfInputs:r+1,numberOfOutputs:a,params:l,functions:u,functionArguments:[]}},ce=(...t)=>pe(e.Javascript,...t),be=(...t)=>pe(e.C,...t),ye=(e,t)=>\"number\"==typeof e?$e(e)(t):e(t),accum=(e,t=0,n)=>{let s;return o((i=>{s=i.alloc(1);let a=ye(e,i),r=ye(t,i),[o]=i.useVariables(\"accum\");void 0!==n.init&&(s.initData=new Float32Array([n.init]));let l=\"number\"==typeof t&&0===t?\"\":`if (${r.variable} > 0) ${o} = ${n.min};`,u=`${n.max-n.min} + ${a.variable}`,m=!(void 0!==n.exclusive&&!n.exclusive),d=!0===m?\">=\":\">\",$=`${i.varKeyword} ${o} = memory[${s.idx}];\\n${l}\\nmemory[${s.idx}] = ${o} + ${a.variable};\\nif (memory[${s.idx}] ${d} ${n.max}) memory[${s.idx}] -= ${m?n.max-n.min:u};\\n`;return i.emit($,o,a,r)}))},fe=(...e)=>t=>{let n=e.map((e=>t.gen(e))),s=`\\nconsole.log(${n.map((e=>e.variable)).join(\",\")});\\n        `;return t.emit(s,n[0].variable,...n)},ge=(e,t)=>n=>{let s=n.gen(e),i=`output${t}`,a=`\\n${i} = ${s.variable};\\n`,r=n.emit(a,i,s);return r.outputs=t,r},ve=(e,t)=>n=>{let[s]=n.useVariables(e),i=n.gen(t),a=`${n.varKeyword} ${s} = ${i.variable};\\n`;return n.emit(a,s,i)},xe={min:0,max:1},we=(e,t=0,n=xe)=>o((s=>{let i=n.max-n.min;return ve(\"phasor\",accum(y(b(e,i),s.sampleRate),t,n))(s)})),cycle=(t,n=0)=>o((s=>{let i=s.gen(t),a=s.gen(n),r=W(d(we(t),n),0,1)(s),[o,l,m,$,h]=s.useVariables(\"floatIndex\",\"frac\",\"clerp\",\"index\",\"nextIndex\");const p=s.target===e.C?\"sineTable\":\"this.sineTable\";let c=s.intKeyword,b=s.varKeyword,y=s.target===e.C?u[\"Math.floor\"]:\"Math.floor\",f=`\\n${r.code}\\n${s.varKeyword} ${o} = ${r.variable} * 1024;\\n${s.varKeyword} ${l} = ${o} - ${y}(${o});\\n${c} ${$} = ${y}(${o});\\n${c} ${h} = ${$} + 1;\\nif (${h} >= 1024) {\\n  ${h} = 0;\\n}\\n${b} ${m} = (1.0-${l})*${p}[${$}] + ${l}*${p}[${h}];\\n`;return s.emit(f,m,i,a)})),Me=()=>{let e,t,n,s=[],i=o((i=>{let a=i!==t;t=i,(void 0===e||a)&&(e=i.alloc(1),n=i.useVariables(\"clickVal\")[0],s=s.filter((e=>!e.context.disposed)),s.push({block:e,context:i}));let r=`\\n${i.varKeyword} ${n} = memory[${e.idx}];\\nif (${n} > 0) {\\n   memory[${e.idx}] = 0;\\n}\\n`;return i.emit(r,n)}));return i.click=(e,t)=>{for(let{context:n,block:i}of s)n.postMessage({type:void 0!==e?\"schedule-set\":\"memory-set\",body:{idx:i.idx,value:void 0===t?1:t,time:e}})},i},Ke=(e,...t)=>o((n=>{let s=n.gen(e),i=t.map((e=>n.gen(e))),[a]=n.useVariables(\"selector\"),r=`${n.varKeyword} ${a} = ${s.variable} <= 0 ? 0.0 : (${s.variable} <= 1 ? ${i[0].variable} : (${s.variable} >= ${i.length} ? ${i[i.length-1].variable} : ${i.map(((e,t)=>`${s.variable} == ${t+1} ? ${e.variable} : `)).join(\"\")} 0.0));`;return n.emit(r,a,s,...i)})),_e=(e,t,n,s,i)=>o((a=>{let r=se(),o=se(),l=se(),u=se(),m=r(o()),$=l(u()),h=l(u()),c=d(i,1),f=C(t),g=b(f,.00014247585730565955";
    }
}
