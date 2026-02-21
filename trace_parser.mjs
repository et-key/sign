const tokens = ['two_one', ':', '2', '1'];
const APPLY_PREC = 6;

const findOp = (op, notation) => {
    if (op === ':' && notation === 'infix') return { precedence: 2, associativity: 'right' };
    return null;
};
const isOpSymbol = (op) => op === ':';

const isSeparator = (token) => false;
const parseAtom = (tokens) => {
    const token = tokens.shift();
    if (!isNaN(parseFloat(token))) return { type: 'number', value: parseFloat(token) };
    return { type: 'identifier', value: token };
};

const parseExpr = (tokens, minPrec = 0) => {
    console.log('parseExpr( minPrec:', minPrec, ') tokens IN:', tokens);
    if (tokens.length === 0) return null;
    let lhs = parseAtom(tokens);
    console.log(' lhs:', lhs.value, 'tokens left:', tokens);

    while (tokens.length > 0) {
        let lookahead = tokens[0];
        console.log(' loop lookahead:', lookahead, 'minPrec:', minPrec);

        if (typeof lookahead === 'string' && isOpSymbol(lookahead)) {
            const opSymbol = lookahead;
            let op = findOp(opSymbol, 'infix');
            if (op) {
                console.log('  found op:', opSymbol, 'prec:', op.precedence);
                if (op.precedence < minPrec) {
                    console.log('  breaking out of op check');
                    break;
                }
                tokens.shift();
                const nextMinPrec = op.associativity === 'right' ? op.precedence : op.precedence + 1;
                const rhs = parseExpr(tokens, nextMinPrec);
                lhs = { type: 'infix', op: opSymbol, left: lhs, right: rhs };
                continue;
            }
        }

        if (APPLY_PREC < minPrec) {
            console.log('  breaking out of APPLY because', APPLY_PREC, '<', minPrec);
            break;
        }

        console.log('  doing APPLY with APPLY_PREC + 1 =', APPLY_PREC + 1);
        const rhsAtom = parseExpr(tokens, APPLY_PREC + 1);
        if (rhsAtom) {
            lhs = { type: 'apply', func: lhs, arg: rhsAtom };
        } else {
            console.log('  no rhs atom found');
            break;
        }
    }
    console.log('returning from minPrec', minPrec, '->', JSON.stringify(lhs).substring(0, 50));
    return lhs;
};

console.log(JSON.stringify(parseExpr(tokens, 0), null, 2));
