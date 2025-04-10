/// @function ease_out_quad(current, target, progress)
/// @param {Number} current  Current camera position (x or y).
/// @param {Number} target   Target camera position (x or y).
/// @param {Number} progress Normalized progress (0 to 1).
/// @returns {Number}         Eased value.
function ease_out_quad(current, target, progress) {
    var change = target - current;
    return change * (1 - (1 - progress) * (1 - progress)) + current;
}