package com.pgnmate.pgn.facade;

import com.pgnmate.pgn.facade.IPGNNode;

/**
 * <h1>PGN Semantic Validation Interface</h1>
 * For each node in the AST validate is called. The validator is call is called in normal
 * pre-order fashion (top-down starting at DB). At this point all lexing and parsing has
 * completed and any nodes (if any) that threw exceptions have been discarded so the AST
 * is syntactically valid. This validator should check semantic validity.
 */
@SuppressWarnings("all")
public interface IPGNValidator {
  public abstract void validate(final IPGNNode node, final Object context);
}
