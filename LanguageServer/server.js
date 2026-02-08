
const {
	createConnection,
	TextDocuments,
	ProposedFeatures,
	DidChangeConfigurationNotification,
	CompletionItem,
	CompletionItemKind,
	TextDocumentSyncKind,
	Diagnostic,
	DiagnosticSeverity
} = require('vscode-languageserver/node');
const { TextDocument } = require('vscode-languageserver-textdocument');

// Import the generated parser
const parser = require('./src/sign-parser.js');

// Create a connection for the server
const connection = createConnection(ProposedFeatures.all);

// Create a simple text document manager
const documents = new TextDocuments(TextDocument);

connection.onInitialize((params) => {
	return {
		capabilities: {
			textDocumentSync: TextDocumentSyncKind.Incremental,
			// Tell the client that this server supports code completion.
			completionProvider: {
				resolveProvider: true
			}
		}
	};
});

connection.onInitialized(() => {
	// connection.client.register(DidChangeConfigurationNotification.type, undefined);
});

// The content of a text document has changed.
documents.onDidChangeContent(change => {
	validateTextDocument(change.document);
});

async function validateTextDocument(textDocument) {
	const text = textDocument.getText();
	const diagnostics = [];

	try {
		parser.parse(text);
	} catch (e) {
		if (e.location) {
			const diagnostic = {
				severity: DiagnosticSeverity.Error,
				range: {
					start: { line: e.location.start.line - 1, character: e.location.start.column - 1 },
					end: { line: e.location.end.line - 1, character: e.location.end.column - 1 }
				},
				message: e.message,
				source: 'Sign LSP'
			};
			diagnostics.push(diagnostic);
		}
	}

	connection.sendDiagnostics({ uri: textDocument.uri, diagnostics });
}

documents.listen(connection);
connection.listen();
