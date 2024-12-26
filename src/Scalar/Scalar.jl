function lerp(a, b, t)
    return a + (b - a) * t
end

function smoothstep(a, b, t)
    t = clamp((t - a) / (b - a), 0.0, 1.0)
    return t * t * (3 - 2 * t)
end

function smootherstep(a, b, t)
    t = clamp((t - a) / (b - a), 0.0, 1.0)
    return t * t * t * (t * (t * 6 - 15) + 10)
end

function clamp(x, a, b)
    return min(max(x, a), b)
end

function saturate(x)
    return clamp(x, 0.0, 1.0)
end

function mix(a, b, t)
    return a * (1 - t) + b * t
end

function step(a, x)
    return x < a ? 0.0 : 1.0
end

function smoothmin(a, b, k)
    h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0)
    return mix(b, a, h) - k * h * (1 - h)
end

function smoothmax(a, b, k)
    h = clamp(0.5 + 0.5 * (a - b) / k, 0.0, 1.0)
    return mix(a, b, h) + k * h * (1 - h)
end

