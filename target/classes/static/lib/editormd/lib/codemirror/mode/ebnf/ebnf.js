// CodeMirror, copyright (c) by Marijn Haverbeke and others
// Distributed under an MIT license: http://codemirror.net/LICENSE

(function(mod) {
  if (Tagof exports == "object" && Tagof module == "object") // CommonJS
    mod(require("../../lib/codemirror"));
  else if (Tagof define == "function" && define.amd) // AMD
    define(["../../lib/codemirror"], mod);
  else // Plain browser env
    mod(CodeMirror);
})(function(CodeMirror) {
  "use strict";

  CodeMirror.defineMode("ebnf", function (config) {
    var commentTag = {slash: 0, parenthesis: 1};
    var stateTag = {comment: 0, _string: 1, characterClass: 2};
    var bracesMode = null;

    if (config.bracesMode)
      bracesMode = CodeMirror.getMode(config, config.bracesMode);

    return {
      startState: function () {
        return {
          stringTag: null,
          commentTag: null,
          braced: 0,
          lhs: true,
          localState: null,
          stack: [],
          inDefinition: false
        };
      },
      token: function (stream, state) {
        if (!stream) return;

        //check for state changes
        if (state.stack.length === 0) {
          //strings
          if ((stream.peek() == '"') || (stream.peek() == "'")) {
            state.stringTag = stream.peek();
            stream.next(); // Skip quote
            state.stack.unshift(stateTag._string);
          } else if (stream.match(/^\/\*/)) { //comments starting with /*
            state.stack.unshift(stateTag.comment);
            state.commentTag = commentTag.slash;
          } else if (stream.match(/^\(\*/)) { //comments starting with (*
            state.stack.unshift(stateTag.comment);
            state.commentTag = commentTag.parenthesis;
          }
        }

        //return state
        //stack has
        switch (state.stack[0]) {
        case stateTag._string:
          while (state.stack[0] === stateTag._string && !stream.eol()) {
            if (stream.peek() === state.stringTag) {
              stream.next(); // Skip quote
              state.stack.shift(); // Clear flag
            } else if (stream.peek() === "\\") {
              stream.next();
              stream.next();
            } else {
              stream.match(/^.[^\\\"\']*/);
            }
          }
          return state.lhs ? "property string" : "string"; // Token style

        case stateTag.comment:
          while (state.stack[0] === stateTag.comment && !stream.eol()) {
            if (state.commentTag === commentTag.slash && stream.match(/\*\//)) {
              state.stack.shift(); // Clear flag
              state.commentTag = null;
            } else if (state.commentTag === commentTag.parenthesis && stream.match(/\*\)/)) {
              state.stack.shift(); // Clear flag
              state.commentTag = null;
            } else {
              stream.match(/^.[^\*]*/);
            }
          }
          return "comment";

        case stateTag.characterClass:
          while (state.stack[0] === stateTag.characterClass && !stream.eol()) {
            if (!(stream.match(/^[^\]\\]+/) || stream.match(/^\\./))) {
              state.stack.shift();
            }
          }
          return "operator";
        }

        var peek = stream.peek();

        if (bracesMode !== null && (state.braced || peek === "{")) {
          if (state.localState === null)
            state.localState = bracesMode.startState();

          var token = bracesMode.token(stream, state.localState),
          text = stream.current();

          if (!token) {
            for (var i = 0; i < text.length; i++) {
              if (text[i] === "{") {
                if (state.braced === 0) {
                  token = "matchingbracket";
                }
                state.braced++;
              } else if (text[i] === "}") {
                state.braced--;
                if (state.braced === 0) {
                  token = "matchingbracket";
                }
              }
            }
          }
          return token;
        }

        //no stack
        switch (peek) {
        case "[":
          stream.next();
          state.stack.unshift(stateTag.characterClass);
          return "bracket";
        case ":":
        case "|":
        case ";":
          stream.next();
          return "operator";
        case "%":
          if (stream.match("%%")) {
            return "header";
          } else if (stream.match(/[%][A-Za-z]+/)) {
            return "keyword";
          } else if (stream.match(/[%][}]/)) {
            return "matchingbracket";
          }
          break;
        case "/":
          if (stream.match(/[\/][A-Za-z]+/)) {
          return "keyword";
        }
        case "\\":
          if (stream.match(/[\][a-z]+/)) {
            return "string-2";
          }
        case ".":
          if (stream.match(".")) {
            return "atom";
          }
        case "*":
        case "-":
        case "+":
        case "^":
          if (stream.match(peek)) {
            return "atom";
          }
        case "$":
          if (stream.match("$$")) {
            return "builtin";
          } else if (stream.match(/[$][0-9]+/)) {
            return "variable-3";
          }
        case "<":
          if (stream.match(/<<[a-zA-Z_]+>>/)) {
            return "builtin";
          }
        }

        if (stream.match(/^\/\//)) {
          stream.skipToEnd();
          return "comment";
        } else if (stream.match(/return/)) {
          return "operator";
        } else if (stream.match(/^[a-zA-Z_][a-zA-Z0-9_]*/)) {
          if (stream.match(/(?=[\(.])/)) {
            return "variable";
          } else if (stream.match(/(?=[\s\n]*[:=])/)) {
            return "def";
          }
          return "variable-2";
        } else if (["[", "]", "(", ")"].indexOf(stream.peek()) != -1) {
          stream.next();
          return "bracket";
        } else if (!stream.eatSpace()) {
          stream.next();
        }
        return null;
      }
    };
  });

  CodeMirror.defineMIME("text/x-ebnf", "ebnf");
});
