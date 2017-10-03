/**
 * Helper that throws an error to trigger a 400 response if a
 * field is missing.
 * @param {Array<string>} requiredFields
 */
function assertRequiredFields(requiredFields = []) {
  const missingFields = requiredFields.filter(field => !!req.body[field]);
  if (missingFields.length > 0) {
    throw new ApplicationError("Missing required fields", 400, {
      requiredFields,
      missingFields
    });
  }
}

/**
 * Wrapper for routes. Does the following:
 * - Routes can be written as async functions
 * - Thrown errors get passed to the `next` callback
 * - Allows you to require fields in the request body
 *   (works only if body-parser is applied earlier) if
 *   options.requiredFields is present (must be an array)
 */
export function route(callback, options = {}) {
  return async (req, res, next) => {
    try {
      if (options.requiredFields) {
        assertRequiredFields(options.requiredFields);
      }

      await callback(req, res, next);
    } catch (err) {
      next(err);
    }
  };
}
