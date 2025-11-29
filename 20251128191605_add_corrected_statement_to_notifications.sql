/*
  # Add Corrected Statement Field to Notifications

  1. Changes
    - Add `corrected_statement` column to `notifications` table
      - This stores the correct, factual information when content is fake or misleading
      - Optional text field (only populated for FALSE/MISLEADING verdicts)
  
  2. Purpose
    - Helps users understand not just what's wrong, but what the truth actually is
    - Provides educational value by showing correct information alongside the fake claim
*/

-- Add corrected_statement column
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'notifications' AND column_name = 'corrected_statement'
  ) THEN
    ALTER TABLE notifications ADD COLUMN corrected_statement text;
  END IF;
END $$;
